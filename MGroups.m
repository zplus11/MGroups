(* ::Package:: *)

BeginPackage["MGroups`"]

FindDomain::usage="Find the domain of the group.
FindDomain[G]"
FindIdentity::usage="Find the identity of the group.
FindIdentity[G]"
ElementPower::usage="Find order of an element of the group.
ElementPower[G, element, power]"
OrderGroup::usage="Find order of the group.
OrderGroup[G]"
ElementInverse::usage="Find the inverse of an element of the group.
ElementInverse[G, element]"
OrderElement::usage="Find the order of an element of the group.
OrderElement[G, element]"
CyclicQ::usage="Check whether the group is cyclic or not.
CyclicQ[G]"
AbelianQ::usage="Check whether the group is abelian or not.
AbelianQ[G]"
CayleyTable::usage="Print the Cayley Table of the group.
CayleyTable[G]"
InversesTable::usage="Print the table of inverses (and orders) of the group.
InversesTable[G]"
SubgroupQ::usage="Check whether a subset forms a subgroup of the group or not.
SubgroupQ[G, H]"
Subgroups::usage="Find all subgroups of the group.
Subgroups[G]"
Coset::usage="Generate a coset of the group.
Coset[G,H,element,orientation"
NormalSubgroupQ::usage="Check whether a subgroup of the group is normal in it or not.
NormalSubgroupQ[G,H]"
NormalSubgroups::usage="Find all normal subgroups of the group.
NormalSubgroups[G]"
AdditiveGroup::usage="Addivitive group of order \!\(\*
StyleBox[\"n\",\nFontSlant->\"Italic\"]\).
AdditiveGroup[n]"
MultiplicativeGroup::usage="Multiplicative group of order phi(\!\(\*
StyleBox[\"n\",\nFontSlant->\"Italic\"]\)).
MultiplicativeGroup[n]"
DihedralGroupp::usage="Dihedral group of order \!\(\*
StyleBox[\"n\",\nFontSlant->\"Italic\"]\).
DihedralGroupp[n]"
ExternalDirectProduct::usage="External Direct Product of \!\(\*
StyleBox[\"n\",\nFontSlant->\"Italic\"]\) groups: \!\(\*SubscriptBox[\(G\), \(1\)]\), \!\(\*SubscriptBox[\(G\), \(2\)]\), ..., \!\(\*SubscriptBox[\(G\), \(3\)]\).
ExternalDirectProduct[G1, G2, ..., Gn]"
 
Begin["`Private`"]

MapToAssociationQ[_->_?AssociationQ]:=True
MapToAssociationQ[___]:=False
GroupQ[Association[___?MapToAssociationQ]]:=True
GroupQ[___]:=False

FindDomain[G_?GroupQ]:=Return[Keys[G]]

FindIdentity[G_?GroupQ]:=Module[
{domain},
Catch[
domain=FindDomain[G];
Do[If[And@@Table[G[x][y]==y==G[y][x],{y,domain}],Throw[x]],{x,domain}];
Throw[Null];
]
]

ElementPower[G_?GroupQ,element_,power_]:=Module[
{domain,result},
Catch[
domain=FindDomain[G];
If[!MemberQ[domain,element],Throw["Invalid Member"]];
result=FindIdentity[G];
Do[result=G[element][result],{i,power}];
Throw[result]
]
]

OrderGroup[G_?GroupQ]:=Return[Length[FindDomain[G]]]
OrderElement[G_?GroupQ,element_]:=Module[
{domain,identity},
Catch[
domain=FindDomain[G];
If[!MemberQ[domain,element],Throw["Invalid Member"]];
identity=FindIdentity[G];
Do[If[ElementPower[G,element,i]==identity,Throw[i]],{i,Divisors[OrderGroup[G]]}];
Throw[Null]
]
]

ElementInverse[G_?GroupQ,element_]:=Module[
{domain,identity},
Catch[
domain=FindDomain[G];
If[!MemberQ[domain,element],Throw["Invalid Member"]];
identity=FindIdentity[G];
Do[If[G[element][x]==identity==G[x][element],Throw[x]],{x,domain}];
Throw[Null];
]
]

CyclicQ[G_?GroupQ]:=Module[
{domain,grouporder},
Catch[
domain=FindDomain[G];
grouporder=OrderGroup[G];
If[Or@@Table[OrderElement[G,x]==grouporder,{x,domain}],Throw[True]];
Throw[False];
]
]

AbelianQ[G_?GroupQ]:=Module[
{domain},
Catch[
domain=FindDomain[G];
Do[If[G[x][y]!=G[y][x],Throw[False]],{x,domain},{y,domain}];
Throw[False]
]
]

CayleyTable[G_?GroupQ]:=Module[
{domain},
domain=FindDomain[G];
TableForm[Table[Table[G[x][y],{y,domain}],{x,domain}],TableHeadings->{domain,domain}]
]

InversesTable[G_?GroupQ]:=Module[
{domain},
domain=FindDomain[G];
TableForm[Table[{x,ElementInverse[G,x],OrderElement[G,x]},{x,FindDomain[G]}],TableHeadings->{None,{"x","\!\(\*SuperscriptBox[\(x\), \(-1\)]\)","|x|"}}]
]

SubgroupQ[G_?GroupQ,H_?ListQ]:=Module[
{domain,identity},
Catch[
domain=FindDomain[G];
identity=FindIdentity[G];
If[!MemberQ[H,identity],Throw[False]];
If[!SubsetQ[domain, H],Throw[False]];
Do[If[!MemberQ[H,G[x][y]],Throw[False]],{x,H},{y,H}];
Throw[True]
]
]

Subgroups[G_?GroupQ]:=Module[
{subsets},
subsets=Complement[Subsets[FindDomain[G]],{{}}];
Return[Select[subsets,SubgroupQ[G,#]&]]
]

Coset[G_?GroupQ,H_,element_,orientation_:"l"]:=Module[
{domain},
Catch[
domain=FindDomain[G];
If[!SubgroupQ[G,H],Throw["Invalid Subgroup"]];
If[!MemberQ[domain,element],Throw["Invalid Member"]];
If[!MemberQ[{"l","r"},orientation],Throw["Invalid Orientation"]];
If[orientation=="l",
Throw[Table[G[x][element],{x,H}]],
Throw[Table[G[element][x],{x,H}]]
]
]
]

NormalSubgroupQ[G_?GroupQ,H_]:=Module[
{domain},
Catch[
domain=FindDomain[G];
If[!SubgroupQ[G,H],Throw[False]];
Do[If[!(Sort@Coset[G,H,x,"l"]===Sort@Coset[G,H,x,"r"]),Throw[False]],{x,domain}];
Throw[True];
]
]

NormalSubgroups[G_?GroupQ]:=Module[
{subgroups},
subgroups=Subgroups[G];
Return[Select[subgroups,NormalSubgroupQ[G,#]&]]
]

AdditiveGroup[n_Integer]:=<|Table[x-><|Table[y->Mod[x+y,n],{y,0,n-1}]|>,{x,0,n-1}]|>
MultiplicativeGroup[n_Integer]:=Module[{coprimes},
coprimes=Select[Range[0,n-1], GCD[#,n]==1&];
<|Table[x-><|Table[y->Mod[x y,n],{y,coprimes}]|>,{x,coprimes}]|>
]
ExternalDirectProduct[Gs___?GroupQ]:=Module[{domain,n},
domain=Tuples[FindDomain/@{Gs}];
n=Length[{Gs}];
<|Table[x-><|Table[y->Table[{Gs}[[i]][x[[i]]][y[[i]]],{i,n}],{y,domain}]|>,{x,domain}]|>
]

applySymmetry[{s1_, s2_}, n_]:=Module[
{n1,n2},
n1=ToExpression[StringDrop[s1, 1]];
n2=ToExpression[StringDrop[s2, 1]];
If[StringTake[s1,1]=="r",
If[StringTake[s2,1]=="r",
Return["r"<>ToString[Mod[n1+n2,n]]],
Return["s"<>ToString[Mod[n1+n2,n]]]
],If[StringTake[s2,1]=="r",
Return["s"<>ToString[Mod[n1-n2,n]]],
Return["r"<>ToString[Mod[n1-n2,n]]]
]
]          
]
s2n[string_]:=Read[StringToStream[string],Number]
DihedralGroupp[n_]:=Module[
{members},
members=Union[Table["r"<>ToString[i],{i,0,n-1}],Table["s"<>ToString[i],{i,0,n-1}]];
Return[
<|Table[x-><|Table[y->applySymmetry[{x,y},n],{y,members}]|>,{x,members}]|>
]
]

End[];
EndPackage[]



