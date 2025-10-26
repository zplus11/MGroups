BeginTestSection["TestSubgroups"]

VerificationTest[(* 1 *)
	MSubgroupQ[
MAdditiveGroup[20], 
2Range[0, 9]
]
	,
	True	
	,
	TestID -> "660cc740-efa2-46ee-a210-d969ee64194c"
]

VerificationTest[(* 2 *)
	MSubgroupQ[
MDihedralGroup[10], 
{MSymmetry[1,3],MSymmetry[0,0],MSymmetry[0,2],MSymmetry[0,3]}
]
	,
	False	
	,
	TestID -> "15b7e686-75b5-4833-9723-2f0b08ba7f09"
]

VerificationTest[(* 3 *)
	Length[MSubgroups[MPermutationsGroup[4],  MPresentation -> "Subgroups"]]
	,
	30	
	,
	TestID -> "258f3782-9824-478a-bc55-45a5f1bee9c0"
]

VerificationTest[(* 4 *)
	MNormalSubgroupQ[MQuaternionGroup,  {"1",  "-1"}]
	,
	True	
	,
	TestID -> "d2ce5c15-f7f6-49ce-82c8-2c0fed52898e"
]

EndTestSection[]
