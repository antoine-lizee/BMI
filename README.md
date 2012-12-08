BMI stands for Brain Machine Interface... or
How to decode the thoughts of a monkey ?
===

## Intro

This is a library that we developed with my team to compete for the departmental Brain Machine Interfacing competition at Imperial College. It features home-made machine-learning algorithms tailored for the purpose of the competition.  
The competition featured two tasks. Performance for ranking was measured by the organising team only. We got the second position for the first task and finished first for the second task, and won the copetition overall.


## Description of the problem

The set-up is as follow: a monkey, Nestor, performs a movement on the 2D plane of a table in front of him while his neural activity is recorded.
The movement is a "targeted one": he has to reach  a target as soon as a light goes off. There are eight different targets that Nestor may have to reach, and the position of the light shows which target to go for.  
In total, 182 trials have been recorded, featuring each time the eight possible targets. For each of the trials, neural activity (Action potentials for 98 neurons) and position of Nestor's hand (x and y coordiantes in the plane) are recorded.   
100 of the trials where public for development of the algorithmn while the data coming from the remaining 82 trials was kept by the organising team to assess performance.

### TASK ONE

The first task is a discrete decoding task whose aim is to determine which one of the eight possible trajectories Nestor was going for only based on the neural activity of the monkey during the 200 ms **prior** to the onset of the movement.
We had to select only 10 neurons from the 98 recorded to run our algorithm.  
Task performance was assessed by the rate of good target recognition (one among eight, for the 8*82 testing trajectories). We achieved performance of 94%.

### TASK TWO

The second task is a continuous decoding task: we have to recreate the entire trajectories of each movement that we recorded from Nestor, again just from the recorded neural activity.
We had the entire neural activity (just before and during the movement) and we had to give an estimated position of NEstor's hand, point after point, each 20 ms.  
Performance was assessed by measuring the distance between each real position and our estimated position.

## Remarks about the code

The code will be uploaded soon, after a bit of a cleaning.