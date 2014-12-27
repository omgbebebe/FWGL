module FWGL.Graphics.Shapes where

import FWGL.Geometry
import FWGL.Graphics.Types
import FWGL.Internal.GL (GLES)
import FWGL.Vector

cubeGeometry :: GLES => Geometry Geometry3
cubeGeometry =
        mkGeometry3
                [ V3 1.0 1.0 (-0.999999), 
                  V3 1.0 (-1.0) (-1.0), 
                  V3 (-1.0) 1.0 (-1.0), 
                  V3 (-1.0) (-1.0) 1.0, 
                  V3 (-1.0) 1.0 1.0, 
                  V3 (-1.0) (-1.0) (-1.0), 
                  V3 (-1.0) (-1.0) 1.0, 
                  V3 1.0 (-1.0) 1.0, 
                  V3 (-1.0) 1.0 1.0, 
                  V3 1.0 (-1.0) 1.0, 
                  V3 1.0 (-1.0) (-1.0), 
                  V3 0.999999 1.0 1.000001, 
                  V3 1.0 1.0 (-0.999999), 
                  V3 (-1.0) 1.0 (-1.0), 
                  V3 0.999999 1.0 1.000001, 
                  V3 1.0 (-1.0) (-1.0), 
                  V3 1.0 (-1.0) 1.0, 
                  V3 (-1.0) (-1.0) (-1.0), 
                  V3 (-1.0) (-1.0) (-1.0), 
                  V3 (-1.0) 1.0 (-1.0), 
                  V3 0.999999 1.0 1.000001, 
                  V3 1.0 1.0 (-0.999999), 
                  V3 (-1.0) 1.0 1.0, 
                  V3 (-1.0) (-1.0) 1.0 ]
                [ V2 0.9999 1.0e-4, 
                  V2 0.9999 0.9999, 
                  V2 1.0e-4 1.0e-4, 
                  V2 1.0e-4 0.9999, 
                  V2 1.0e-4 1.0e-4, 
                  V2 0.9999 0.9999, 
                  V2 1.0e-4 1.0e-4, 
                  V2 0.9999 1.0e-4, 
                  V2 1.0e-4 0.9999, 
                  V2 1.0e-4 1.0e-4, 
                  V2 0.9999 1.0e-4, 
                  V2 1.0e-4 0.9999, 
                  V2 0.9999 0.9999, 
                  V2 1.0e-4 0.9999, 
                  V2 0.9999 1.0e-4, 
                  V2 0.9999 0.9999, 
                  V2 1.0e-4 0.9999, 
                  V2 0.9999 1.0e-4, 
                  V2 1.0e-4 0.9999, 
                  V2 0.9999 1.0e-4, 
                  V2 0.9999 0.9999, 
                  V2 0.9999 0.9999, 
                  V2 1.0e-4 1.0e-4, 
                  V2 1.0e-4 1.0e-4 ]
                [ V3 0.0 0.0 (-1.0), 
                  V3 0.0 0.0 (-1.0), 
                  V3 0.0 0.0 (-1.0), 
                  V3 (-1.0) (-0.0) (-0.0), 
                  V3 (-1.0) (-0.0) (-0.0), 
                  V3 (-1.0) (-0.0) (-0.0), 
                  V3 (-0.0) (-0.0) 1.0, 
                  V3 (-0.0) (-0.0) 1.0, 
                  V3 (-0.0) (-0.0) 1.0, 
                  V3 1.0 (-0.0) 0.0, 
                  V3 1.0 (-0.0) 0.0, 
                  V3 1.0 (-0.0) 0.0, 
                  V3 0.0 1.0 0.0, 
                  V3 0.0 1.0 0.0, 
                  V3 0.0 1.0 0.0, 
                  V3 0.0 (-1.0) 0.0, 
                  V3 0.0 (-1.0) 0.0, 
                  V3 0.0 (-1.0) 0.0, 
                  V3 0.0 0.0 (-1.0), 
                  V3 (-1.0) (-0.0) (-0.0), 
                  V3 (-0.0) (-0.0) 1.0, 
                  V3 1.0 (-0.0) 0.0, 
                  V3 0.0 1.0 0.0, 
                  V3 0.0 (-1.0) 0.0 ]
                [ 0, 1, 2,
                3, 4, 5,
                6, 7, 8,
                9, 10, 11,
                12, 13, 14,
                15, 16, 17,
                1, 18, 2,
                4, 19, 5,
                7, 20, 8,
                10, 21, 11,
                13, 22, 14,
                16, 23, 17 ]