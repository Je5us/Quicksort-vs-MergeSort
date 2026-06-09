set terminal pngcairo size 1000,700
set key outside
set xlabel "n"
set grid

# --- 1. Tiempo promedio (entrada aleatoria) ---
set logscale y
set ylabel "Tiempo promedio (s)"
set title "Tiempo promedio: quicksort vs merge sort (random)"
set output "results/time_random.png"
plot \
  "< awk -F, 'NR>1 && $2==\"random\" && $1==\"quick\" && $6==1 {sum[$3]+=$5; c[$3]++} END{for(n in sum) print n, sum[n]/c[n]}' results/results.csv | sort -n" \
    using 1:2 with linespoints title "quicksort", \
  "< awk -F, 'NR>1 && $2==\"random\" && $1==\"merge\" && $6==1 {sum[$3]+=$5; c[$3]++} END{for(n in sum) print n, sum[n]/c[n]}' results/results.csv | sort -n" \
    using 1:2 with linespoints title "merge sort"

# --- 2. Tiempo normalizado por n*log2(n) (entrada aleatoria) ---
set ylabel "Tiempo / (n log2 n)"
set title "Tiempo normalizado: quicksort vs merge sort (random)"
set output "results/normalized_random.png"
plot \
  "< awk -F, 'function log2(x){return log(x)/log(2)} NR>1 && $2==\"random\" && $1==\"quick\" && $6==1 {sum[$3]+=$5; c[$3]++} END{for(n in sum) print n, (sum[n]/c[n])/(n*log2(n))}' results/results.csv | sort -n" \
    using 1:2 with linespoints title "quicksort", \
  "< awk -F, 'function log2(x){return log(x)/log(2)} NR>1 && $2==\"random\" && $1==\"merge\" && $6==1 {sum[$3]+=$5; c[$3]++} END{for(n in sum) print n, (sum[n]/c[n])/(n*log2(n))}' results/results.csv | sort -n" \
    using 1:2 with linespoints title "merge sort"

# --- 3. Razon R(n) = T_merge / T_quick (entrada aleatoria) ---
unset logscale y
set ylabel "R(n) = T_merge / T_quick"
set title "Razón de tiempos (random): R(n) > 1 => quicksort más rápido"
set output "results/ratio_random.png"
plot \
  "< awk -F, 'NR>1 && $2==\"random\" && $6==1 {sum[$1\",\"$3]+=$5; c[$1\",\"$3]++} END{for(k in c){split(k,a,\",\"); avg[a[1]\",\"a[2]]=sum[k]/c[k]} for(k in avg){split(k,a,\",\"); if(a[1]==\"merge\"){n=a[2]; q=avg[\"quick,\"n]; if(q>0) print n, avg[k]/q}}}' results/results.csv | sort -n" \
    using 1:2 with linespoints title "R(n)"
