Test[
  MGroupDomain[MAdditiveGroup[3]],
  {0, 1, 2}
]

Test[
  MGroupIdentity[MMultiplicativeGroup[10]],
  1
]

Test[
  MMultiplicativeGroup[10][3][7],
  1
]

Test[
  MAbelianQ[MAdditiveGroup[5]],
  True
]

Test[
  MCyclicQ[MMultiplicativeGroup[8], {1, 7}],
  True
]

Test[
  MAbelianQ[MDihedralGroup[3]],
  False
]

Test[
  MElementInverse[MAdditiveGroup[4], 2],
  2
]

Test[
  MGroupDomain[FormMGroup[{0, 1}, Mod[#1 + #2, 2] &]],
  {0, 1}
]

Test[
  MGroupOrder[MEDP[MDihedralGroup[3], MPermutationsGroup[3]]],
  36
]
