## This is the message bus with global events that any script can emit or connect to
class_name Events_Class
extends Node

## The player found an exit
signal ExitHit

## The timer has run out
signal TimeExpired

## A monster is munching on the player
signal MonsterHitPlayer(Node3D)
