## Nutures
## 20210916
## Selective intrachromosomal interactions

import sys
import os
import pandas as pd
import argparse
def main(argv):
    parser = argparse.ArgumentParser(description="")
    parser.add_argument('-b', "--bedfile", required=True, help="The bed file generated by HiC-Pro")
    parser.add_argument('-m', '--matrixfile', required=True, help="Matrix file generated by HiC-Pro")
    parser.add_argument('-o', "--outdir", required=True, help = 'Output file directory')
    parser.add_argument('-YN', '--Scaffold', required=True, help="Is scaffold internal interaction required")
    args = parser.parse_args()
    bed_f = args.bedfile
    mtx_f = args.matrixfile
    out_dir = args.outdir
    is_scaf = args.Scaffold
    df_bed = pd.read_csv(bed_f, sep='\t', names=['chr', 's', 'e', 'id'])
    df_mtx = pd.read_csv(mtx_f, sep='\t', names=['bin1', 'bin2', 'reads'])
    #Determine if the scaffold id need to be remove
    if is_scaf == 'NO' or is_scaf == 'no' or is_scaf == 'N':
        df_bed = df_bed.query("~chr.str.contains('Scaff')", engine='python').copy()
        #df_bed = df_bed.query("~chr.str.contains('Contig')", engine='python').copy()
    # get need chr id
    chr_id = sorted(set(list(df_bed['chr'])))
    #print(chr_id)
    n = 1
    for c in chr_id:
        names = "{0}_{0}.txt".format(n)
        out_f1 = os.path.join(out_dir, names)
        out_f2 = os.path.join(out_dir, c+"_abs.bed")
        df_chr = df_bed.query("chr == @c").copy()
        id_start = df_chr['id'].min()
        id_end = df_chr['id'].max()
        df_chr_mtx = df_mtx.query("(bin1 >= @id_start) & (bin1 <= @id_end) & (bin2 >= @id_start) & (bin2 <= @id_end)").copy()
        df_chr_mtx['bin1'] = df_chr_mtx['bin1'] - id_start + 1
        df_chr_mtx['bin2'] = df_chr_mtx['bin2'] - id_start + 1
        df_chr['id'] = df_chr['id'] - id_start + 1
        df_chr_mtx.to_csv(out_f1, sep='\t', index=False, header=False)
        df_chr.to_csv(out_f2, sep='\t', index=False, header=False)
        n += 1
if __name__ == "__main__":
    main(sys.argv[1:])
