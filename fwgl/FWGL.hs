{-|
    The main module. You should also import a backend:

        * FWGL.Backend.JavaScript: GHCJS/WebGL backend (contained in fwgl-javascript)
        * FWGL.Backend.GLFW.GL20: GLFW/OpenGL 2.0 backend (contained in fwgl-glfw)
        * FWGL.Backend.GLFW.GLES20: GLFW/OpenGL ES 2.0 backend (WIP)


    And a graphics system:

        * "FWGL.Graphics.D2": 2D graphics
        * "FWGL.Graphics.D3": 3D graphics
        * "FWGL.Graphics.Custom": advanced custom graphics

    "FWGL.Shader" contains the EDSL to make custom shaders.
-}
module FWGL (
        module FWGL.Audio,
        module FWGL.Input,
        module FWGL.Utils,
        module FRP.Yampa,
        Output(..),
        run
) where

import FWGL.Audio
import FWGL.Backend
import FWGL.Input
import FWGL.Internal.GL (evalGL)
import FWGL.Graphics.Draw
import FWGL.Graphics.Types
import FWGL.Utils
import FRP.Yampa

-- | The general output.
data Output = Output [Layer] Audio -- StateT ... IO

-- | Run a FWGL program.
run :: BackendIO
    => SF Input Output  -- ^ Main signal
    -> IO ()
run sigf = setup initState loop sigf
        where initState w h = evalGL $ drawInit w h
              loop (Output scenes _) ctx drawState =
                      flip evalGL ctx . flip execDraw drawState $
                              do drawBegin
                                 mapM_ drawLayer scenes
                                 drawEnd
