# Spectrum Filtering and LNA
In order to receive the satellite signals from the ground station, unused portions of the frequency spectrum should be filtered.
Otherwise, unintentional interference signals may mask the signals of interest rather by themselves or by their harmonics. 
The best practice is to use a bandpass filter immediately after the receiving antenna, before passing the signals to the following active system components such as an LNA, a mixer, or an ADC.

Although bandpass filters can be designed by lumped elements easily by using the filter synthesis tool of QucsStudio, implementation of the designs require fine tuning and a lot of effort.
The best way to implement a filter in a circuit/setup is to use a filter module or IC. For bandpass filtering, SAW filters are the best selection, in most of the cases.

If the signal of interest is not limited in a narrow band (such as a task of wideband spectrum monitoring), a bandstop filter that filters unwanted strong signals can also be employed.
Most of the amateur V/UHF setups suffer from strong FM broadcast signals. For most of the situations, if the dynamic range is not extremely limited and the interference is not extremely high, a simple FM bandstop filter can be used to block the unwanted signals, hence their products.

