echo "cata <- matrix(c($1,$2,$3,$4),ncol=2);"
echo "colnames(cata) <- c('Alliterative', 'Plain');"
echo "rownames(cata) <- c('Correct', 'Incorrect');"
echo "chisq.test(cata);"

echo "catb <- matrix(c($5,$6,$7,$8),ncol=2);"
echo "colnames(catb) <- c('Alliterative', 'Plain');"
echo "rownames(catb) <- c('Correct', 'Incorrect');"
echo "chisq.test(catb);"

echo "catc <- matrix(c($9,${10},${11},${12}),ncol=2);"
echo "colnames(catc) <- c('Alliterative', 'Plain');"
echo "rownames(catc) <- c('Correct', 'Incorrect');"
echo "chisq.test(catc);"

echo "var_a = $1+$5+$9"
echo "var_b = $2+$6+${10}"
echo "var_c = $3+$7+${11}"
echo "var_d = $4+$8+${12}"

echo "cats <- matrix(c(var_a,var_b,var_c,var_d),ncol=2);"
echo "colnames(cats) <- c('Alliterative', 'Plain');"
echo "rownames(cats) <- c('Correct', 'Incorrect');"
echo "chisq.test(cats);"