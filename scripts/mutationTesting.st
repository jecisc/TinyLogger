Metacello new
    githubUser: 'jecisc' project: 'TinyLogger' commitish: 'v1.x.x' path: 'src';
    baseline: 'TinyLogger';
    load.
    
Metacello new
  baseline: 'MuTalk';
  repository: 'github://pavel-krivanek/mutalk/src';
  load.

analysis := MutationTestingAnalysis
    testCasesFrom: 'TinyLogger-Tests' asPackage definedClasses 
    mutating: 'TinyLogger' asPackage definedClasses
    using: MutantOperator contents
    with: AllTestsMethodsRunningMutantEvaluationStrategy new.
analysis run.
alive := analysis generalResult aliveMutants.

browser := GLMTabulator new.
browser 
    row: #results;
    row: #diff.
browser transmit to: #results.
browser transmit to: #diff; from: #results; andShow: [ :a | 
    a diff display: [ :mutant | {((RBParser parseMethod: (mutant mutant originalSource)) formattedCode) . ((RBParser parseMethod: (mutant mutant modifiedSource)) formattedCode)}] ].
browser openOn: alive.