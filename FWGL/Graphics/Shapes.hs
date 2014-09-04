module FWGL.Graphics.Shapes where

import FWGL.Geometry -- tmp
import FWGL.Graphics.Types
import FWGL.Vector

{- cubeGeometry :: Geometry
cubeGeometry =
        Geometry {
                vertices = [ V3   1  (-1) (-1)
                           , V3   1  (-1)   1
                           , V3 (-1) (-1)   1
                           , V3 (-1) (-1) (-1)
                           , V3   1    1  (-1)
                           , V3   1    1    1
                           , V3 (-1)   1    1
                           , V3 (-1)   1  (-1) ],
                uvCoords = [],
                normals = [],
                elements = [ 1, 2, 3
                           , 7, 6, 5
                           , 0, 4, 5
                           , 1, 5, 6
                           , 6, 7, 3
                           , 0, 3, 7
                           , 0, 1, 3
                           , 4, 7, 5
                           , 1, 0, 5
                           , 2, 1, 6
                           , 2, 6, 3
                           , 4, 0, 7 ]
        } -}

cubeGeometry :: Geometry
cubeGeometry =
        Geometry {
                vertices = [ V3 1.0 1.0 (-0.999999), 
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
                             V3 (-1.0) (-1.0) 1.0
                ],
                uvCoords = [ V2 0.9999 1.0e-4, 
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
                             V2 1.0e-4 1.0e-4
                ],
                normals = [ V3 0.0 0.0 (-1.0), 
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
                            V3 0.0 (-1.0) 0.0
                ],
                elements = [ 0, 1, 2,
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
                             16, 23, 17
                ],
                hash = -3836634754025509170
        }