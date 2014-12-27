{-# LANGUAGE NullaryTypeClasses, TypeFamilies, MultiParamTypeClasses #-}

module FWGL.Backend.OpenGL.GLES20 () where
        
import Data.Word
import Foreign
import Foreign.C.String
import FWGL.Backend.OpenGL.Common
import FWGL.Backend.GLES
import FWGL.Vector
import qualified Graphics.GL.Embedded20 as ES
import Graphics.GL.Types as ES

instance GLES where
        type Ctx = ()
        type GLEnum = GLenum
        type GLUInt = GLuint
        type GLInt = GLint
        type GLPtr = Ptr ()
        type GLPtrDiff = GLintptr
        type GLSize = GLsizei
        type GLString = String -- XXX: Foreign CChar?
        type GLBool = GLboolean
        type Buffer = GLuint
        type UniformLocation = GLint
        type Texture = GLuint
        type Shader = GLuint
        type Program = GLuint
        type FrameBuffer = GLuint
        type RenderBuffer = GLuint
        -- type ShaderPrecisionFormat = GLint
        type Array = (GLsizei, ForeignPtr ())
        type Float32Array = (GLsizei, ForeignPtr GLfloat)
        type Int32Array = (GLsizei, ForeignPtr GLint)
        type Image = (GLsizei, GLsizei, Ptr ())

        true = 1
        false = 0
        nullGLPtr = nullPtr
        toGLString = id
        noBuffer = 0
        noTexture = 0

        -- TODO: move to FWGL.Backend.OpenGL.Common
        encodeM2 (M2 (V2 a1 a2) (V2 b1 b2)) = mkArray [ a1, a2, b1, b2]

        encodeM3 (M3 (V3 a1 a2 a3)
                     (V3 b1 b2 b3)
                     (V3 c1 c2 c3)) = mkArray [ a1, a2, a3
                                              , b1, b2, b3
                                              , c1, c2, c3 ]
        encodeM4 (M4 (V4 a1 a2 a3 a4)
                     (V4 b1 b2 b3 b4)
                     (V4 c1 c2 c3 c4)
                     (V4 d1 d2 d3 d4) ) = mkArray [ a1, a2, a3, a4
                                                  , b1, b2, b3, b4
                                                  , c1, c2, c3, c4
                                                  , d1, d2, d3, d4 ]

        encodeFloats = mkArray
        encodeV2s = mkArray
        encodeV3s = mkArray
        encodeV4s = mkArray
        encodeUShorts = mkArray
        encodeColors = mkArray

        glActiveTexture = const ES.glActiveTexture
        glAttachShader = const ES.glAttachShader
        glBindAttribLocation _ a b c = withCString c $ ES.glBindAttribLocation a b
        glBindBuffer = const ES.glBindBuffer
        glBindFramebuffer = const ES.glBindFramebuffer
        glBindRenderbuffer = const ES.glBindRenderbuffer
        glBindTexture = const ES.glBindTexture
        glBlendColor = const ES.glBlendColor
        glBlendEquation = const ES.glBlendEquation
        glBlendEquationSeparate = const ES.glBlendEquationSeparate
        glBlendFunc = const ES.glBlendFunc
        glBlendFuncSeparate = const ES.glBlendFuncSeparate
        glBufferData _ a (l, fp) b = withForeignPtr fp $ \p ->
                ES.glBufferData a (fromIntegral l) p b
        glBufferSubData _ a b (l, fp) = withForeignPtr fp $ \p ->
                ES.glBufferSubData a b (fromIntegral l) p
        glCheckFramebufferStatus = const ES.glCheckFramebufferStatus
        glClear = const ES.glClear
        glClearColor = const ES.glClearColor
        glClearDepth = const ES.glClearDepthf
        glClearStencil = const ES.glClearStencil
        glColorMask = const ES.glColorMask
        glCompileShader = const ES.glCompileShader
        glCompressedTexImage2D _ a b c d e f (l, fp) = withForeignPtr fp $
                \p -> ES.glCompressedTexImage2D a b c d e f l p
        glCompressedTexSubImage2D _ a b c d e f g (l, fp) = withForeignPtr fp $
                \p -> ES.glCompressedTexSubImage2D a b c d e f g l p
        glCopyTexImage2D = const ES.glCopyTexImage2D
        glCopyTexSubImage2D = const ES.glCopyTexSubImage2D
        glCreateBuffer = genToCreate ES.glGenBuffers
        glCreateFramebuffer = genToCreate ES.glGenFramebuffers
        glCreateProgram = const ES.glCreateProgram
        glCreateRenderbuffer = genToCreate ES.glGenRenderbuffers
        glCreateShader = const ES.glCreateShader
        glCreateTexture = genToCreate ES.glGenTextures
        glCullFace = const ES.glCullFace
        glDeleteBuffer = deleteToDelete ES.glDeleteBuffers
        glDeleteFramebuffer = deleteToDelete ES.glDeleteFramebuffers
        glDeleteProgram = const ES.glDeleteProgram
        glDeleteRenderbuffer = deleteToDelete ES.glDeleteRenderbuffers
        glDeleteShader = const ES.glDeleteShader
        glDeleteTexture = deleteToDelete ES.glDeleteTextures
        glDepthFunc = const ES.glDepthFunc
        glDepthMask = const ES.glDepthMask
        glDepthRange = const ES.glDepthRangef
        glDetachShader = const ES.glDetachShader
        glDisable = const ES.glDisable
        glDisableVertexAttribArray = const ES.glDisableVertexAttribArray
        glDrawArrays = const ES.glDrawArrays
        glDrawElements = const ES.glDrawElements
        glEnable = const ES.glEnable
        glEnableVertexAttribArray = const ES.glEnableVertexAttribArray
        glFinish = const ES.glFinish
        glFlush = const ES.glFlush
        glFramebufferRenderbuffer = const ES.glFramebufferRenderbuffer
        glFramebufferTexture2D = const ES.glFramebufferTexture2D
        glFrontFace = const ES.glFrontFace
        glGenerateMipmap = const ES.glGenerateMipmap
        glGetAttribLocation _ a b = withCString b $ ES.glGetAttribLocation a
        glGetError = const ES.glGetError
        glGetProgramInfoLog = getString ES.glGetProgramInfoLog
        glGetShaderInfoLog = getString ES.glGetShaderInfoLog
        glGetShaderSource = getString ES.glGetShaderSource
        glGetUniformLocation _ a b = withCString b $ ES.glGetUniformLocation a
        glHint = const ES.glHint
        glIsBuffer = const ES.glIsBuffer
        glIsEnabled = const ES.glIsEnabled
        glIsFramebuffer = const ES.glIsFramebuffer
        glIsProgram = const ES.glIsProgram
        glIsRenderbuffer = const ES.glIsRenderbuffer
        glIsShader = const ES.glIsShader
        glIsTexture = const ES.glIsTexture
        glLineWidth = const ES.glLineWidth
        glLinkProgram = const ES.glLinkProgram
        glPixelStorei = const ES.glPixelStorei
        glPolygonOffset = const ES.glPolygonOffset
        glReadPixels _ a b c d e f (_, fp)  = withForeignPtr fp $
                ES.glReadPixels a b c d e f
        glRenderbufferStorage = const ES.glRenderbufferStorage
        glSampleCoverage = const ES.glSampleCoverage
        glScissor = const ES.glScissor
        glShaderSource _ shader src =
                withCString src $ \csrc ->
                        with (fromIntegral $ length src) $ \lenptr ->
                               with csrc $ \csrcptr ->
                                      ES.glShaderSource shader 1 csrcptr lenptr
        glStencilFunc = const ES.glStencilFunc
        glStencilFuncSeparate = const ES.glStencilFuncSeparate
        glStencilMask = const ES.glStencilMask
        glStencilMaskSeparate = const ES.glStencilMaskSeparate
        glStencilOp = const ES.glStencilOp
        glStencilOpSeparate = const ES.glStencilOpSeparate
        glTexImage2DBuffer _ a b c d e f g h (_, fp) = withForeignPtr fp $
                ES.glTexImage2D a b c d e f g h
        glTexImage2DImage _ target lvl iform form ty (w, h, p) =
                ES.glTexImage2D target lvl iform w h 0 form ty p
        glTexParameterf = const ES.glTexParameterf
        glTexParameteri = const ES.glTexParameteri
        glTexSubImage2D _ a b c d e f g h (_, fp) = withForeignPtr fp $
                ES.glTexSubImage2D a b c d e f g h
        glUniform1f = const ES.glUniform1f
        glUniform1fv = uniform ES.glUniform1fv
        glUniform1i = const ES.glUniform1i
        glUniform1iv = uniform ES.glUniform1iv
        glUniform2f = const ES.glUniform2f
        glUniform2fv = uniform ES.glUniform2fv
        glUniform2i = const ES.glUniform2i
        glUniform2iv = uniform ES.glUniform2iv
        glUniform3f = const ES.glUniform3f
        glUniform3fv = uniform ES.glUniform3fv
        glUniform3i = const ES.glUniform3i
        glUniform3iv = uniform ES.glUniform3iv
        glUniform4f = const ES.glUniform4f
        glUniform4fv = uniform ES.glUniform4fv
        glUniform4i = const ES.glUniform4i
        glUniform4iv = uniform ES.glUniform4iv
        glUniformMatrix2fv = uniformMatrix ES.glUniformMatrix2fv 4
        glUniformMatrix3fv = uniformMatrix ES.glUniformMatrix3fv 9
        glUniformMatrix4fv = uniformMatrix ES.glUniformMatrix4fv 16
        glUseProgram = const ES.glUseProgram
        glValidateProgram = const ES.glValidateProgram
        glVertexAttrib1f = const ES.glVertexAttrib1f
        glVertexAttrib1fv = vertexAttrib ES.glVertexAttrib1fv
        glVertexAttrib2f = const ES.glVertexAttrib2f
        glVertexAttrib2fv = vertexAttrib ES.glVertexAttrib2fv
        glVertexAttrib3f = const ES.glVertexAttrib3f
        glVertexAttrib3fv = vertexAttrib ES.glVertexAttrib3fv
        glVertexAttrib4f = const ES.glVertexAttrib4f
        glVertexAttrib4fv = vertexAttrib ES.glVertexAttrib4fv
        glVertexAttribPointer = const ES.glVertexAttribPointer
        glViewport = const ES.glViewport

        gl_DEPTH_BUFFER_BIT = ES.GL_DEPTH_BUFFER_BIT
        gl_STENCIL_BUFFER_BIT = ES.GL_STENCIL_BUFFER_BIT
        gl_COLOR_BUFFER_BIT = ES.GL_COLOR_BUFFER_BIT
        gl_POINTS = ES.GL_POINTS
        gl_LINES = ES.GL_LINES
        gl_LINE_LOOP = ES.GL_LINE_LOOP
        gl_LINE_STRIP = ES.GL_LINE_STRIP
        gl_TRIANGLES = ES.GL_TRIANGLES
        gl_TRIANGLE_STRIP = ES.GL_TRIANGLE_STRIP
        gl_TRIANGLE_FAN = ES.GL_TRIANGLE_FAN
        gl_ZERO = ES.GL_ZERO
        gl_ONE = ES.GL_ONE
        gl_SRC_COLOR = ES.GL_SRC_COLOR
        gl_ONE_MINUS_SRC_COLOR = ES.GL_ONE_MINUS_SRC_COLOR
        gl_SRC_ALPHA = ES.GL_SRC_ALPHA
        gl_ONE_MINUS_SRC_ALPHA = ES.GL_ONE_MINUS_SRC_ALPHA
        gl_DST_ALPHA = ES.GL_DST_ALPHA
        gl_ONE_MINUS_DST_ALPHA = ES.GL_ONE_MINUS_DST_ALPHA
        gl_DST_COLOR = ES.GL_DST_COLOR
        gl_ONE_MINUS_DST_COLOR = ES.GL_ONE_MINUS_DST_COLOR
        gl_SRC_ALPHA_SATURATE = ES.GL_SRC_ALPHA_SATURATE
        gl_FUNC_ADD = ES.GL_FUNC_ADD
        gl_BLEND_EQUATION = ES.GL_BLEND_EQUATION
        gl_BLEND_EQUATION_RGB = ES.GL_BLEND_EQUATION_RGB
        gl_BLEND_EQUATION_ALPHA = ES.GL_BLEND_EQUATION_ALPHA
        gl_FUNC_SUBTRACT = ES.GL_FUNC_SUBTRACT
        gl_FUNC_REVERSE_SUBTRACT = ES.GL_FUNC_REVERSE_SUBTRACT
        gl_BLEND_DST_RGB = ES.GL_BLEND_DST_RGB
        gl_BLEND_SRC_RGB = ES.GL_BLEND_SRC_RGB
        gl_BLEND_DST_ALPHA = ES.GL_BLEND_DST_ALPHA
        gl_BLEND_SRC_ALPHA = ES.GL_BLEND_SRC_ALPHA
        gl_CONSTANT_COLOR = ES.GL_CONSTANT_COLOR
        gl_ONE_MINUS_CONSTANT_COLOR = ES.GL_ONE_MINUS_CONSTANT_COLOR
        gl_CONSTANT_ALPHA = ES.GL_CONSTANT_ALPHA
        gl_ONE_MINUS_CONSTANT_ALPHA = ES.GL_ONE_MINUS_CONSTANT_ALPHA
        gl_BLEND_COLOR = ES.GL_BLEND_COLOR
        gl_ARRAY_BUFFER = ES.GL_ARRAY_BUFFER
        gl_ELEMENT_ARRAY_BUFFER = ES.GL_ELEMENT_ARRAY_BUFFER
        gl_ARRAY_BUFFER_BINDING = ES.GL_ARRAY_BUFFER_BINDING
        gl_ELEMENT_ARRAY_BUFFER_BINDING = ES.GL_ELEMENT_ARRAY_BUFFER_BINDING
        gl_STREAM_DRAW = ES.GL_STREAM_DRAW
        gl_STATIC_DRAW = ES.GL_STATIC_DRAW
        gl_DYNAMIC_DRAW = ES.GL_DYNAMIC_DRAW
        gl_BUFFER_SIZE = ES.GL_BUFFER_SIZE
        gl_BUFFER_USAGE = ES.GL_BUFFER_USAGE
        gl_CURRENT_VERTEX_ATTRIB = ES.GL_CURRENT_VERTEX_ATTRIB
        gl_FRONT = ES.GL_FRONT
        gl_BACK = ES.GL_BACK
        gl_FRONT_AND_BACK = ES.GL_FRONT_AND_BACK
        gl_CULL_FACE = ES.GL_CULL_FACE
        gl_BLEND = ES.GL_BLEND
        gl_DITHER = ES.GL_DITHER
        gl_STENCIL_TEST = ES.GL_STENCIL_TEST
        gl_DEPTH_TEST = ES.GL_DEPTH_TEST
        gl_SCISSOR_TEST = ES.GL_SCISSOR_TEST
        gl_POLYGON_OFFSET_FILL = ES.GL_POLYGON_OFFSET_FILL
        gl_SAMPLE_ALPHA_TO_COVERAGE = ES.GL_SAMPLE_ALPHA_TO_COVERAGE
        gl_SAMPLE_COVERAGE = ES.GL_SAMPLE_COVERAGE
        gl_NO_ERROR = ES.GL_NO_ERROR
        gl_INVALID_ENUM = ES.GL_INVALID_ENUM
        gl_INVALID_VALUE = ES.GL_INVALID_VALUE
        gl_INVALID_OPERATION = ES.GL_INVALID_OPERATION
        gl_OUT_OF_MEMORY = ES.GL_OUT_OF_MEMORY
        gl_CW = ES.GL_CW
        gl_CCW = ES.GL_CCW
        gl_LINE_WIDTH = ES.GL_LINE_WIDTH
        gl_ALIASED_POINT_SIZE_RANGE = ES.GL_ALIASED_POINT_SIZE_RANGE
        gl_ALIASED_LINE_WIDTH_RANGE = ES.GL_ALIASED_LINE_WIDTH_RANGE
        gl_CULL_FACE_MODE = ES.GL_CULL_FACE_MODE
        gl_FRONT_FACE = ES.GL_FRONT_FACE
        gl_DEPTH_RANGE = ES.GL_DEPTH_RANGE
        gl_DEPTH_WRITEMASK = ES.GL_DEPTH_WRITEMASK
        gl_DEPTH_CLEAR_VALUE = ES.GL_DEPTH_CLEAR_VALUE
        gl_DEPTH_FUNC = ES.GL_DEPTH_FUNC
        gl_STENCIL_CLEAR_VALUE = ES.GL_STENCIL_CLEAR_VALUE
        gl_STENCIL_FUNC = ES.GL_STENCIL_FUNC
        gl_STENCIL_FAIL = ES.GL_STENCIL_FAIL
        gl_STENCIL_PASS_DEPTH_FAIL = ES.GL_STENCIL_PASS_DEPTH_FAIL
        gl_STENCIL_PASS_DEPTH_PASS = ES.GL_STENCIL_PASS_DEPTH_PASS
        gl_STENCIL_REF = ES.GL_STENCIL_REF
        gl_STENCIL_VALUE_MASK = ES.GL_STENCIL_VALUE_MASK
        gl_STENCIL_WRITEMASK = ES.GL_STENCIL_WRITEMASK
        gl_STENCIL_BACK_FUNC = ES.GL_STENCIL_BACK_FUNC
        gl_STENCIL_BACK_FAIL = ES.GL_STENCIL_BACK_FAIL
        gl_STENCIL_BACK_PASS_DEPTH_FAIL = ES.GL_STENCIL_BACK_PASS_DEPTH_FAIL
        gl_STENCIL_BACK_PASS_DEPTH_PASS = ES.GL_STENCIL_BACK_PASS_DEPTH_PASS
        gl_STENCIL_BACK_REF = ES.GL_STENCIL_BACK_REF
        gl_STENCIL_BACK_VALUE_MASK = ES.GL_STENCIL_BACK_VALUE_MASK
        gl_STENCIL_BACK_WRITEMASK = ES.GL_STENCIL_BACK_WRITEMASK
        gl_VIEWPORT = ES.GL_VIEWPORT
        gl_SCISSOR_BOX = ES.GL_SCISSOR_BOX
        gl_COLOR_CLEAR_VALUE = ES.GL_COLOR_CLEAR_VALUE
        gl_COLOR_WRITEMASK = ES.GL_COLOR_WRITEMASK
        gl_UNPACK_ALIGNMENT = ES.GL_UNPACK_ALIGNMENT
        gl_PACK_ALIGNMENT = ES.GL_PACK_ALIGNMENT
        gl_MAX_TEXTURE_SIZE = ES.GL_MAX_TEXTURE_SIZE
        gl_MAX_VIEWPORT_DIMS = ES.GL_MAX_VIEWPORT_DIMS
        gl_SUBPIXEL_BITS = ES.GL_SUBPIXEL_BITS
        gl_RED_BITS = ES.GL_RED_BITS
        gl_GREEN_BITS = ES.GL_GREEN_BITS
        gl_BLUE_BITS = ES.GL_BLUE_BITS
        gl_ALPHA_BITS = ES.GL_ALPHA_BITS
        gl_DEPTH_BITS = ES.GL_DEPTH_BITS
        gl_STENCIL_BITS = ES.GL_STENCIL_BITS
        gl_POLYGON_OFFSET_UNITS = ES.GL_POLYGON_OFFSET_UNITS
        gl_POLYGON_OFFSET_FACTOR = ES.GL_POLYGON_OFFSET_FACTOR
        gl_TEXTURE_BINDING_2D = ES.GL_TEXTURE_BINDING_2D
        gl_SAMPLE_BUFFERS = ES.GL_SAMPLE_BUFFERS
        gl_SAMPLES = ES.GL_SAMPLES
        gl_SAMPLE_COVERAGE_VALUE = ES.GL_SAMPLE_COVERAGE_VALUE
        gl_SAMPLE_COVERAGE_INVERT = ES.GL_SAMPLE_COVERAGE_INVERT
        gl_COMPRESSED_TEXTURE_FORMATS = ES.GL_COMPRESSED_TEXTURE_FORMATS
        gl_DONT_CARE = ES.GL_DONT_CARE
        gl_FASTEST = ES.GL_FASTEST
        gl_NICEST = ES.GL_NICEST
        gl_GENERATE_MIPMAP_HINT = ES.GL_GENERATE_MIPMAP_HINT
        gl_BYTE = ES.GL_BYTE
        gl_UNSIGNED_BYTE = ES.GL_UNSIGNED_BYTE
        gl_SHORT = ES.GL_SHORT
        gl_UNSIGNED_SHORT = ES.GL_UNSIGNED_SHORT
        gl_INT = ES.GL_INT
        gl_UNSIGNED_INT = ES.GL_UNSIGNED_INT
        gl_FLOAT = ES.GL_FLOAT
        gl_DEPTH_COMPONENT = ES.GL_DEPTH_COMPONENT
        gl_ALPHA = ES.GL_ALPHA
        gl_RGB = ES.GL_RGB
        gl_RGBA = ES.GL_RGBA
        gl_LUMINANCE = ES.GL_LUMINANCE
        gl_LUMINANCE_ALPHA = ES.GL_LUMINANCE_ALPHA
        gl_UNSIGNED_SHORT_4_4_4_4 = ES.GL_UNSIGNED_SHORT_4_4_4_4
        gl_UNSIGNED_SHORT_5_5_5_1 = ES.GL_UNSIGNED_SHORT_5_5_5_1
        gl_UNSIGNED_SHORT_5_6_5 = ES.GL_UNSIGNED_SHORT_5_6_5
        gl_FRAGMENT_SHADER = ES.GL_FRAGMENT_SHADER
        gl_VERTEX_SHADER = ES.GL_VERTEX_SHADER
        gl_MAX_VERTEX_ATTRIBS = ES.GL_MAX_VERTEX_ATTRIBS
        gl_MAX_VERTEX_UNIFORM_VECTORS = ES.GL_MAX_VERTEX_UNIFORM_VECTORS
        gl_MAX_VARYING_VECTORS = ES.GL_MAX_VARYING_VECTORS
        gl_MAX_COMBINED_TEXTURE_IMAGE_UNITS = ES.GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS
        gl_MAX_VERTEX_TEXTURE_IMAGE_UNITS = ES.GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS
        gl_MAX_TEXTURE_IMAGE_UNITS = ES.GL_MAX_TEXTURE_IMAGE_UNITS
        gl_MAX_FRAGMENT_UNIFORM_VECTORS = ES.GL_MAX_FRAGMENT_UNIFORM_VECTORS
        gl_SHADER_TYPE = ES.GL_SHADER_TYPE
        gl_DELETE_STATUS = ES.GL_DELETE_STATUS
        gl_LINK_STATUS = ES.GL_LINK_STATUS
        gl_VALIDATE_STATUS = ES.GL_VALIDATE_STATUS
        gl_ATTACHED_SHADERS = ES.GL_ATTACHED_SHADERS
        gl_ACTIVE_UNIFORMS = ES.GL_ACTIVE_UNIFORMS
        gl_ACTIVE_ATTRIBUTES = ES.GL_ACTIVE_ATTRIBUTES
        gl_SHADING_LANGUAGE_VERSION = ES.GL_SHADING_LANGUAGE_VERSION
        gl_CURRENT_PROGRAM = ES.GL_CURRENT_PROGRAM
        gl_NEVER = ES.GL_NEVER
        gl_LESS = ES.GL_LESS
        gl_EQUAL = ES.GL_EQUAL
        gl_LEQUAL = ES.GL_LEQUAL
        gl_GREATER = ES.GL_GREATER
        gl_NOTEQUAL = ES.GL_NOTEQUAL
        gl_GEQUAL = ES.GL_GEQUAL
        gl_ALWAYS = ES.GL_ALWAYS
        gl_KEEP = ES.GL_KEEP
        gl_REPLACE = ES.GL_REPLACE
        gl_INCR = ES.GL_INCR
        gl_DECR = ES.GL_DECR
        gl_INVERT = ES.GL_INVERT
        gl_INCR_WRAP = ES.GL_INCR_WRAP
        gl_DECR_WRAP = ES.GL_DECR_WRAP
        gl_VENDOR = ES.GL_VENDOR
        gl_RENDERER = ES.GL_RENDERER
        gl_VERSION = ES.GL_VERSION
        gl_NEAREST = ES.GL_NEAREST
        gl_LINEAR = ES.GL_LINEAR
        gl_NEAREST_MIPMAP_NEAREST = ES.GL_NEAREST_MIPMAP_NEAREST
        gl_LINEAR_MIPMAP_NEAREST = ES.GL_LINEAR_MIPMAP_NEAREST
        gl_NEAREST_MIPMAP_LINEAR = ES.GL_NEAREST_MIPMAP_LINEAR
        gl_LINEAR_MIPMAP_LINEAR = ES.GL_LINEAR_MIPMAP_LINEAR
        gl_TEXTURE_MAG_FILTER = ES.GL_TEXTURE_MAG_FILTER
        gl_TEXTURE_MIN_FILTER = ES.GL_TEXTURE_MIN_FILTER
        gl_TEXTURE_WRAP_S = ES.GL_TEXTURE_WRAP_S
        gl_TEXTURE_WRAP_T = ES.GL_TEXTURE_WRAP_T
        gl_TEXTURE_2D = ES.GL_TEXTURE_2D
        gl_TEXTURE = ES.GL_TEXTURE
        gl_TEXTURE_CUBE_MAP = ES.GL_TEXTURE_CUBE_MAP
        gl_TEXTURE_BINDING_CUBE_MAP = ES.GL_TEXTURE_BINDING_CUBE_MAP
        gl_TEXTURE_CUBE_MAP_POSITIVE_X = ES.GL_TEXTURE_CUBE_MAP_POSITIVE_X
        gl_TEXTURE_CUBE_MAP_NEGATIVE_X = ES.GL_TEXTURE_CUBE_MAP_NEGATIVE_X
        gl_TEXTURE_CUBE_MAP_POSITIVE_Y = ES.GL_TEXTURE_CUBE_MAP_POSITIVE_Y
        gl_TEXTURE_CUBE_MAP_NEGATIVE_Y = ES.GL_TEXTURE_CUBE_MAP_NEGATIVE_Y
        gl_TEXTURE_CUBE_MAP_POSITIVE_Z = ES.GL_TEXTURE_CUBE_MAP_POSITIVE_Z
        gl_TEXTURE_CUBE_MAP_NEGATIVE_Z = ES.GL_TEXTURE_CUBE_MAP_NEGATIVE_Z
        gl_MAX_CUBE_MAP_TEXTURE_SIZE = ES.GL_MAX_CUBE_MAP_TEXTURE_SIZE
        gl_TEXTURE0 = ES.GL_TEXTURE0
        gl_TEXTURE1 = ES.GL_TEXTURE1
        gl_TEXTURE2 = ES.GL_TEXTURE2
        gl_TEXTURE3 = ES.GL_TEXTURE3
        gl_TEXTURE4 = ES.GL_TEXTURE4
        gl_TEXTURE5 = ES.GL_TEXTURE5
        gl_TEXTURE6 = ES.GL_TEXTURE6
        gl_TEXTURE7 = ES.GL_TEXTURE7
        gl_TEXTURE8 = ES.GL_TEXTURE8
        gl_TEXTURE9 = ES.GL_TEXTURE9
        gl_TEXTURE10 = ES.GL_TEXTURE10
        gl_TEXTURE11 = ES.GL_TEXTURE11
        gl_TEXTURE12 = ES.GL_TEXTURE12
        gl_TEXTURE13 = ES.GL_TEXTURE13
        gl_TEXTURE14 = ES.GL_TEXTURE14
        gl_TEXTURE15 = ES.GL_TEXTURE15
        gl_TEXTURE16 = ES.GL_TEXTURE16
        gl_TEXTURE17 = ES.GL_TEXTURE17
        gl_TEXTURE18 = ES.GL_TEXTURE18
        gl_TEXTURE19 = ES.GL_TEXTURE19
        gl_TEXTURE20 = ES.GL_TEXTURE20
        gl_TEXTURE21 = ES.GL_TEXTURE21
        gl_TEXTURE22 = ES.GL_TEXTURE22
        gl_TEXTURE23 = ES.GL_TEXTURE23
        gl_TEXTURE24 = ES.GL_TEXTURE24
        gl_TEXTURE25 = ES.GL_TEXTURE25
        gl_TEXTURE26 = ES.GL_TEXTURE26
        gl_TEXTURE27 = ES.GL_TEXTURE27
        gl_TEXTURE28 = ES.GL_TEXTURE28
        gl_TEXTURE29 = ES.GL_TEXTURE29
        gl_TEXTURE30 = ES.GL_TEXTURE30
        gl_TEXTURE31 = ES.GL_TEXTURE31
        gl_ACTIVE_TEXTURE = ES.GL_ACTIVE_TEXTURE
        gl_REPEAT = ES.GL_REPEAT
        gl_CLAMP_TO_EDGE = ES.GL_CLAMP_TO_EDGE
        gl_MIRRORED_REPEAT = ES.GL_MIRRORED_REPEAT
        gl_FLOAT_VEC2 = ES.GL_FLOAT_VEC2
        gl_FLOAT_VEC3 = ES.GL_FLOAT_VEC3
        gl_FLOAT_VEC4 = ES.GL_FLOAT_VEC4
        gl_INT_VEC2 = ES.GL_INT_VEC2
        gl_INT_VEC3 = ES.GL_INT_VEC3
        gl_INT_VEC4 = ES.GL_INT_VEC4
        gl_BOOL = ES.GL_BOOL
        gl_BOOL_VEC2 = ES.GL_BOOL_VEC2
        gl_BOOL_VEC3 = ES.GL_BOOL_VEC3
        gl_BOOL_VEC4 = ES.GL_BOOL_VEC4
        gl_FLOAT_MAT2 = ES.GL_FLOAT_MAT2
        gl_FLOAT_MAT3 = ES.GL_FLOAT_MAT3
        gl_FLOAT_MAT4 = ES.GL_FLOAT_MAT4
        gl_SAMPLER_2D = ES.GL_SAMPLER_2D
        gl_SAMPLER_CUBE = ES.GL_SAMPLER_CUBE
        gl_VERTEX_ATTRIB_ARRAY_ENABLED = ES.GL_VERTEX_ATTRIB_ARRAY_ENABLED
        gl_VERTEX_ATTRIB_ARRAY_SIZE = ES.GL_VERTEX_ATTRIB_ARRAY_SIZE
        gl_VERTEX_ATTRIB_ARRAY_STRIDE = ES.GL_VERTEX_ATTRIB_ARRAY_STRIDE
        gl_VERTEX_ATTRIB_ARRAY_TYPE = ES.GL_VERTEX_ATTRIB_ARRAY_TYPE
        gl_VERTEX_ATTRIB_ARRAY_NORMALIZED = ES.GL_VERTEX_ATTRIB_ARRAY_NORMALIZED
        gl_VERTEX_ATTRIB_ARRAY_POINTER = ES.GL_VERTEX_ATTRIB_ARRAY_POINTER
        gl_VERTEX_ATTRIB_ARRAY_BUFFER_BINDING = ES.GL_VERTEX_ATTRIB_ARRAY_BUFFER_BINDING
        gl_COMPILE_STATUS = ES.GL_COMPILE_STATUS
        gl_LOW_FLOAT = ES.GL_LOW_FLOAT
        gl_MEDIUM_FLOAT = ES.GL_MEDIUM_FLOAT
        gl_HIGH_FLOAT = ES.GL_HIGH_FLOAT
        gl_LOW_INT = ES.GL_LOW_INT
        gl_MEDIUM_INT = ES.GL_MEDIUM_INT
        gl_HIGH_INT = ES.GL_HIGH_INT
        gl_FRAMEBUFFER = ES.GL_FRAMEBUFFER
        gl_RENDERBUFFER = ES.GL_RENDERBUFFER
        gl_RGBA4 = ES.GL_RGBA4
        gl_RGB5_A1 = ES.GL_RGB5_A1
        gl_RGB565 = ES.GL_RGB565
        gl_DEPTH_COMPONENT16 = ES.GL_DEPTH_COMPONENT16
        gl_STENCIL_INDEX8 = ES.GL_STENCIL_INDEX8
        gl_RENDERBUFFER_WIDTH = ES.GL_RENDERBUFFER_WIDTH
        gl_RENDERBUFFER_HEIGHT = ES.GL_RENDERBUFFER_HEIGHT
        gl_RENDERBUFFER_INTERNAL_FORMAT = ES.GL_RENDERBUFFER_INTERNAL_FORMAT
        gl_RENDERBUFFER_RED_SIZE = ES.GL_RENDERBUFFER_RED_SIZE
        gl_RENDERBUFFER_GREEN_SIZE = ES.GL_RENDERBUFFER_GREEN_SIZE
        gl_RENDERBUFFER_BLUE_SIZE = ES.GL_RENDERBUFFER_BLUE_SIZE
        gl_RENDERBUFFER_ALPHA_SIZE = ES.GL_RENDERBUFFER_ALPHA_SIZE
        gl_RENDERBUFFER_DEPTH_SIZE = ES.GL_RENDERBUFFER_DEPTH_SIZE
        gl_RENDERBUFFER_STENCIL_SIZE = ES.GL_RENDERBUFFER_STENCIL_SIZE
        gl_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE = ES.GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE
        gl_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME = ES.GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME
        gl_FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL = ES.GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL
        gl_FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE = ES.GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE
        gl_COLOR_ATTACHMENT0 = ES.GL_COLOR_ATTACHMENT0
        gl_DEPTH_ATTACHMENT = ES.GL_DEPTH_ATTACHMENT
        gl_STENCIL_ATTACHMENT = ES.GL_STENCIL_ATTACHMENT
        gl_NONE = ES.GL_NONE
        gl_FRAMEBUFFER_COMPLETE = ES.GL_FRAMEBUFFER_COMPLETE
        gl_FRAMEBUFFER_INCOMPLETE_ATTACHMENT = ES.GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT
        gl_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT = ES.GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT
        gl_FRAMEBUFFER_INCOMPLETE_DIMENSIONS = ES.GL_FRAMEBUFFER_INCOMPLETE_DIMENSIONS
        gl_FRAMEBUFFER_UNSUPPORTED = ES.GL_FRAMEBUFFER_UNSUPPORTED
        gl_FRAMEBUFFER_BINDING = ES.GL_FRAMEBUFFER_BINDING
        gl_RENDERBUFFER_BINDING = ES.GL_RENDERBUFFER_BINDING
        gl_MAX_RENDERBUFFER_SIZE = ES.GL_MAX_RENDERBUFFER_SIZE
        gl_INVALID_FRAMEBUFFER_OPERATION = ES.GL_INVALID_FRAMEBUFFER_OPERATION
