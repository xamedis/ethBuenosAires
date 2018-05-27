## EtherBuenosAires: Workshop + Hackathon (https://ethbuenosaires.devpost.com)

## Aragon Proposal: *Poll for voting trend analysis*

### Introduction

A core feature of the Aragon platform is the ability to define governance mechanisms so people can decide whether an action should be taken. In the present implementation, a voting instance is set when an entity with the proper rights makes a proposal defining an ending time and the amount of holders needed for validate that voting. This tool allows users with the proper rights to decide the execution or not for the proposed action when the voting finishes. Different mechanisms have also been discussed to encourage voting. However, the binary voting implementation requires a careful choice of the question, otherwise DAO users could loose interest on the presented topic. A major improvement in the proposal's elaboration process can be achieved with the integration of a poll app in such a way new proposals can be analyzed according to which options of that original poll are taken into consideration. Therefore, more precise questions can be released into the  voting app based on the analysis of that poll. 

### Workflow

The assumption of this proposal is that a DAO [#DAODef] should have the ability to perform a trend analysis before the voting proposals. This requires to collect some anonymous opinions of the DAO users regarding general topics of the organization. With this information, and through a voting simulation application, the DAO itself would infer to some extent the posible outcome of a real voting, using some simple statistical analysis.

To this end, one would need to: 

- set questions about relevant topics for the DAO and 
- a minimum number of user's opinions (*a quorum*) respect to the total number of users in the DAO. 

The opinion poll can be defined immediately after the DAO is created or at any time after, by accessing to a poll setting menu. After the DAO is deployed, any user would have the chance to score all the requested topics at any time. Major advantages of this approach are that, if the quorum is reached, the feasibility of any proposal can be analyzed before the voting is released while the DAO's users are asked to fill in their interests in the DAO just once. 

## A Case study: County Government

A county government uses Aragon platform to manage county's costs and take decisions based on citizens voting campaigns. For example, a  set topics defined in the DAO could be the following:  

1. Prefer local outdoor celebrations,  
2. Invest in maintenance of public buildings,  
3. Extend open new green areas,  
4. Improve the cleaning services,  
5. Enhance security,  

and so on. The county's major with a reduced budget wants to take some decisions about how to optimize the use of his resources. So before allocating the money he decides uses the Poll app to get some data analysis before releasing popular voting. Choosing some of the prior features of the poll she notes that the citizens value the cleanness of the city, so she targets the voting into this topic.

## A Poll app example

A Poll app example is provided in the solidity code below. Some caveats and ideas are included in the code.

## Acknowledgements

We would like to thank all the EthBuenosAires organizers for a fantastic work, Aragon-er María Gomez for the feedback and Decentraland-er E. Ordano for the help with some obscure solidity stuff.






