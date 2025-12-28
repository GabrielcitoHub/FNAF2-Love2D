return (
    save.night == 1 and 7000 or
    save.night == 2 and 6000 or
    save.night == 3 and 5000 or
    save.night == 4 and 4000 or
    save.night >= 5 and 3000
)