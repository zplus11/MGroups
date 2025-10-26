BeginTestSection["TestBasic"]

VerificationTest[(* 1 *)
	MGroupDomain[MAdditiveGroup[3]]
	,
	{0,  1, 2}	
	,
	TestID -> "b7dd6cc0-0c7e-40f5-b31b-b8df9473ad7d"
]

VerificationTest[(* 2 *)
	MGroupIdentity[MMultiplicativeGroup[10]]
	,
	1	
	,
	TestID -> "2de7ef1f-3b2f-4b60-ab8e-c027429b5856"
]

VerificationTest[(* 3 *)
	MMultiplicativeGroup[10][3][7]
	,
	1	
	,
	TestID -> "8b1b6b9a-e459-4646-a030-f0ef8cdde71c"
]

VerificationTest[(* 4 *)
	MAbelianQ[MAdditiveGroup[5]]
	,
	True	
	,
	TestID -> "31cc1342-6b6a-4052-973a-38394d912706"
]

VerificationTest[(* 5 *)
	MCyclicQ[MMultiplicativeGroup[8],  {1,  7}]
	,
	True	
	,
	TestID -> "2e4c7d16-516f-4eae-a8fd-935a1c4cf703"
]

VerificationTest[(* 6 *)
	MAbelianQ[MDihedralGroup[3]]
	,
	False	
	,
	TestID -> "5bd89bbf-e9b1-48cb-aca6-7c8cdbd7c09d"
]

VerificationTest[(* 7 *)
	MElementInverse[MAdditiveGroup[4],  2]
	,
	2	
	,
	TestID -> "70ad1c2b-12c3-4a6e-864d-1d1cb322d1c2"
]

EndTestSection[]
