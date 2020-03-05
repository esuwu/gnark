#!/usr/bin/env sage

import sys
from sage.all import *

# Compute the result of a multi-exponentiation in the G1, G2 torsion groups of bls381

# set numPoints as desired
numPoints=10000

# bls381 fp modulus
p=4002409555221667393417789825735904156556882819939007885332058136124031650490837864442687629129015664037894272559787

# bls381 fr modulus
r=52435875175126190479447740508185965837690552500527637822603658699938581184513

# large multiplicative generator of fr
exp=42033899646658082535995012643440421268349534540760060111646640675404812871419

#
# G1
#
Fp=GF(p)
E=EllipticCurve(Fp, [0,4])

# generator of torsion group G1 with order r
G1=E(2407661716269791519325591009883849385849641130669941829988413640673772478386903154468379397813974815295049686961384,821462058248938975967615814494474302717441302457255475448080663619194518120412959273482223614332657512049995916067)

R1=G1-G1 # initialize point at infinity
nextpoint=R1
nextscalar=1
for i in range(numPoints):
    nextpoint = nextpoint + G1
    nextscalar = nextscalar * exp % r
    R1 = R1 + nextscalar * nextpoint
print "G1:", numPoints, R1

#
# G2
#
Fp2.<u> = GF(p^2, modulus=x^2+1)
Etwist = EllipticCurve(Fp2, [0, 4*(u+1)])

# generator of torsion group G2 with order r
G2 = Etwist([3914881020997020027725320596272602335133880006033342744016315347583472833929664105802124952724390025419912690116411+277275454976865553761595788585036366131740173742845697399904006633521909118147462773311856983264184840438626176168*u, 253800087101532902362860387055050889666401414686580130872654083467859828854605749525591159464755920666929166876282+1710145663789443622734372402738721070158916073226464929008132596760920130516982819361355832232719175024697380252309*u])

R2=G2-G2 # initialize point at infinity
nextpoint=R2
nextscalar=1
for i in range(numPoints):
    nextpoint = nextpoint + G2
    nextscalar = nextscalar * exp % r
    R2 = R2 + nextscalar * nextpoint
print "G2:", numPoints, R2

#
# G1 edge cases
#
# P1 = E(1033606393457524462202509281301391801774795384185741853644472965267802293960888374171626887455592584665037630738774, 3621796482720998302222855382742072090172959453363519638042647136675190127709381413539787942875187889828554162336553)
# s = 115792089237316195423570985008687907853269984665640564039457584007913129639935
# print "maxuint*P1:", s*P1

#
# G2 edge cases
#
# P2 = Etwist(3530486458255518483646657753300465068233361547001606344843397309332648122759199161038835588610138188998735896249365 + 556359626370552735366469208656132171537953714011244503981293113570685962099899069626710494303020175970496332053819*u, 688206249007371037300932698574694060421430775835917018620054976409346176157603328155654383245339911153033552044328 + 159347828284068266532164708674697800959559338289778389611370325567206642394897182319932651433026161219393286360146*u)
# s = 115792089237316195423570985008687907853269984665640564039457584007913129639935
# print "maxuint*P2:", s*P2