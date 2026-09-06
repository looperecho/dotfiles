#!/bin/bash

case "$1" in
    "50-50")
        niri msg action set-column-width "50%"
        niri msg action focus-column-right
        niri msg action set-column-width "50%"
        niri msg action focus-column-left
        ;;

    "60-30")
        niri msg action set-column-width "66.6667%"
        niri msg action focus-column-right
        niri msg action set-column-width "33.3333%"
        niri msg action focus-column-left
        ;;

    "30-60")
        niri msg action set-column-width "33.3333%"
        niri msg action focus-column-right
        niri msg action set-column-width "66.6667%"
        niri msg action focus-column-left
        ;;

    *)

        exit 1
        ;;
esac
