# Powell-Sabinov makro element
*Avtor: Tim Kmecl, Tadej Mohorčič*

Implementacija C1 in C2 Powell-Sabinovih makro elementov ter Powel-Sabinove delitve v MATLABU za seminarsko nalogo pri predmetu RPGO.

## Navodila za uporabo

Prenesite mapo [`matlab`](matlab) in jo odprite v MATLAB-u. Nato zaženite posamezno `_demo.m` datoteko za demonstracijo.

## Vsebina

### Powel-Sabinova delitev

[`PS_refinement.m`](matlab/PS_refinement.m) implementira Powel-Sabinovo delitev. Za demonstracijo zaženite [`PS_refinement_demo.m`](matlab/PS_refinement_demo.m), z `enter` se korak po koraku izvede delitev.

### C1 makro element

[`PowellSabine.m`](matlab/PowellSabine.m) implementira izračun kontrolnih točk za C1 makro element. Za demonstracijo zaženite [`C1_demo.m`](matlab/C1_demo.m).

### C2 makro element

[`c2ps.m`](matlab/c2ps.m) implementira izračun kontrolnih točk za C2 makro element. Za demonstracijo zaženite [`C2_demo.m`](matlab/C2_demo.m).