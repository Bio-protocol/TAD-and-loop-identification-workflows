bin_f=$1
mtx_f=$2
python single_chr_interaction.py -b ${bin_f} -m ${mtx_f} -o ./input_f -YN N
for c in Gbar_A01 Gbar_A02 Gbar_A03 Gbar_A04 Gbar_A05 Gbar_A06 Gbar_A07 Gbar_A08 Gbar_A09 Gbar_A10 Gbar_A11 Gbar_A12 Gbar_A13 Gbar_D01 Gbar_D02 Gbar_D03 Gbar_D04 Gbar_D05 Gbar_D06 Gbar_D07 Gbar_D08 Gbar_D09 Gbar_D10 Gbar_D11 Gbar_D12 Gbar_D13
do
{
 python hicpro2fithic.py -i ./input_f/${c}.matrix -b ./input_f/${c}_abs.bed -r 5000 -o ./input_f -n ${c}
 fithic -f ./input_f/${c}.fithic.fragmentMappability.gz -i ./input_f/${c}.fithic.interactionCounts.gz -r 5000 -L 6000 -U 3000000 -p 2 -b 200 -o ./output_f -l ${c}
}
done
