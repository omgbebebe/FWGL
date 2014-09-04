module FWGL.Vector (
        V2(..),
        V3(..),
        V4(..),
        M2(..),
        M3(..),
        M4(..),
        vec2,
        vec3,
        vec4,
        mat2,
        mat3,
        mat4,
        mul4,
        idMat,
        transMat,
        rotXMat,
        rotYMat,
        rotZMat,
        scaleMat
) where

import Control.Applicative
import Data.Hashable
import Foreign.Storable
import Foreign.Ptr (castPtr)

-- | Two-dimensional vector.
data V2 = V2 !Float !Float deriving (Show, Eq)

-- | Three-dimensional vector.
data V3 = V3 !Float !Float !Float deriving (Show, Eq)

data V4 = V4 !Float !Float !Float !Float deriving (Show, Eq)

data M2 = M2 !V2 !V2 deriving (Show, Eq)
data M3 = M3 !V3 !V3 !V3 deriving (Show, Eq)
data M4 = M4 !V4 !V4 !V4 !V4 deriving (Show, Eq)

instance Hashable V2 where
        hashWithSalt s (V2 x y) = hashWithSalt s (x, y)

instance Hashable V3 where
        hashWithSalt s (V3 x y z) = hashWithSalt s (x, y, z)

instance Hashable V4 where
        hashWithSalt s (V4 x y z w) = hashWithSalt s (x, y, z, w)

instance Storable V2 where
        sizeOf _ = 2 * sizeOf (undefined :: Float)
        alignment _ = alignment (undefined :: Float)
        peek ptr = V2 <$> peek (castPtr ptr)
                      <*> peekElemOff (castPtr ptr) 1
        poke ptr (V2 x y) = poke (castPtr ptr) x >> pokeElemOff (castPtr ptr) 1 y

instance Storable V3 where
        sizeOf _ = 3 * sizeOf (undefined :: Float)
        alignment _ = alignment (undefined :: Float)
        peek ptr = V3 <$> peek (castPtr ptr)
                      <*> peekElemOff (castPtr ptr) 1
                      <*> peekElemOff (castPtr ptr) 2
        poke ptr (V3 x y z) = zipWithM_ (pokeElemOff $ castPtr ptr)
                                        [0 .. 2] [x, y, z]
instance Storable V4 where
        sizeOf _ = 4 * sizeOf (undefined :: Float)
        alignment _ = alignment (undefined :: Float)
        peek ptr = V4 <$> peek (castPtr ptr) 
                      <*> peekElemOff (castPtr ptr) 1
                      <*> peekElemOff (castPtr ptr) 2
                      <*> peekElemOff (castPtr ptr) 3
        poke ptr (V4 x y z w) = zipWithM_ (pokeElemOff $ castPtr ptr)
                                          [0 .. 3] [x, y, z, w]

-- | Creates a two-dimensional vector.
vec2 :: (Float, Float) -> V2
vec2 = uncurry V2

-- | Creates a three-dimensional vector.
vec3 :: (Float, Float, Float) -> V3
vec3 (x, y, z) = V3 x y z

vec4 :: (Float, Float, Float, Float) -> V4
vec4 (x, y, z, w) = V4 x y z w

mat2 :: ( Float, Float
        , Float, Float ) -> M2
mat2 (a, a', b, b') = M2 (V2 a a') (V2 b b')

mat3 :: ( Float, Float, Float
        , Float, Float, Float
        , Float, Float, Float ) -> M3
mat3 (a1, a2, a3, b1, b2, b3, c1, c2, c3) =
        M3 (V3 a1 a2 a3)
           (V3 b1 b2 b3)
           (V3 c1 c2 c3)

mat4 :: ( Float, Float, Float, Float
        , Float, Float, Float, Float
        , Float, Float, Float, Float
        , Float, Float, Float, Float ) -> M4
mat4 (a1, a2, a3, a4, b1, b2, b3, b4, c1, c2, c3, c4, d1, d2, d3, d4) =
        M4 (V4 a1 a2 a3 a4)
           (V4 b1 b2 b3 b4)
           (V4 c1 c2 c3 c4)
           (V4 d1 d2 d3 d4)

mul4 :: M4 -> M4 -> M4
mul4 (M4 (V4 _1 _2 _3 _4)
         (V4 _5 _6 _7 _8)
         (V4 _9 _a _b _c)
         (V4 _d _e _f _g))
     (M4 (V4 a b c d)
	 (V4 e f g h)
	 (V4 i j k l)
	 (V4 m n o p)) =
        mat4 (
                _1 * a + _2 * e + _3 * i + _4 * m,
                _1 * b + _2 * f + _3 * j + _4 * n,
                _1 * c + _2 * g + _3 * k + _4 * o,
                _1 * d + _2 * h + _3 * l + _4 * p,

                _5 * a + _6 * e + _7 * i + _8 * m,
                _5 * b + _6 * f + _7 * j + _8 * n,
                _5 * c + _6 * g + _7 * k + _8 * o,
                _5 * d + _6 * h + _7 * l + _8 * p,

                _9 * a + _a * e + _b * i + _c * m,
                _9 * b + _a * f + _b * j + _c * n,
                _9 * c + _a * g + _b * k + _c * o,
                _9 * d + _a * h + _b * l + _c * p,

                _d * a + _e * e + _f * i + _g * m,
                _d * b + _e * f + _f * j + _g * n,
                _d * c + _e * g + _f * k + _g * o,
                _d * d + _e * h + _f * l + _g * p
        )

transpose4 :: M4 -> M4
transpose4 (M4 (V4 a1 a2 a3 a4)
               (V4 b1 b2 b3 b4)
               (V4 c1 c2 c3 c4)
               (V4 d1 d2 d3 d4)) = M4 (V4 a1 b1 c1 d1)
                                      (V4 a2 b2 c2 d2)
                                      (V4 a3 b3 c3 d3)
                                      (V4 a4 b4 c4 d4)

idMat :: M4
idMat = mat4 ( 1, 0, 0, 0
             , 0, 1, 0, 0
             , 0, 0, 1, 0
             , 0, 0, 0, 1 )

transMat :: V3 -> M4
transMat (V3 x y z) = mat4 ( 1, 0, 0, 0
                           , 0, 1, 0, 0
                           , 0, 0, 1, 0
                           , x, y, z, 1 )

rotXMat :: Float -> M4
rotXMat a = mat4 ( 1, 0, 0, 0
                 , 0, cos a, - sin a, 0
                 , 0, sin a, cos a, 0
                 , 0, 0, 0, 1 )

rotYMat :: Float -> M4
rotYMat a = mat4 ( cos a, 0, sin a, 0
                 , 0, 1, 0, 0
                 , - sin a, 0, cos a, 0
                 , 0, 0, 0, 1 )

rotZMat :: Float -> M4
rotZMat a = mat4 ( cos a, - sin a, 0, 0
                 , sin a, cos a, 0, 0
                 , 0, 0, 1, 0
                 , 0, 0, 0, 1 )

scaleMat :: V3 -> M4
scaleMat (V3 x y z) = mat4 ( x, 0, 0, 0
                           , 0, y, 0, 0
                           , 0, 0, z, 0
                           , 0, 0, 0, 1 )

zipWithM_ :: Monad m => (a -> b -> m c) -> [a] -> [b] -> m ()
zipWithM_ f xs = sequence_ . zipWith f xs
