## Filtering
In order to receive the satellite signals from the ground station, unused portions of the frequency spectrum should be filtered.
Otherwise, unintentional interference signals may mask the signals of interest rather by themselves or by their harmonics. 
The best practice is to use a bandpass filter immediately after the receiving antenna, before passing the signals to the following active system components such as an LNA, a mixer, or an ADC.

Although bandpass filters can be designed by lumped elements easily by using the filter synthesis tool of QucsStudio, implementation of the designs require fine tuning and a lot of effort.
The best way to implement a filter in a circuit/setup is to use a filter module or IC. For bandpass filtering, SAW filters are the best selection, in most of the cases.

If the signal of interest is not limited in a narrow band (such as a task of wideband spectrum monitoring), a bandstop filter that filters unwanted strong signals can also be employed.
Most of the amateur V/UHF setups suffer from strong FM broadcast signals. For most of the situations, if the dynamic range is not extremely limited and the interference is not extremely high, a simple FM bandstop filter can be used to block the unwanted signals, hence their products.

## Frequency Band of Interest
[Transmitter list in the spectrum view of SatNOGS DB](https://db.satnogs.org/transmitters#spectrum) is a good resource to determine the valuable portions of the spectrum for UHF LEO satellite receiving system design. Since we don't have any specific target but trying to receive most of the satellites, it is best to cover the most crowded portions of the spectrum.

The main focus in this study is to receive the signals in the range 435 MHz to 439 MHz and the side focus is to receive in the range 400 MHz to 403 MHz. The corners of this frequency ranges are not sharp, but the designs aim to receive the middle portion of these ranges. This is because of the possible discrepancy between the datasheet values and the real life performance of the filters, and the possible frequency shift that may arise when the components in the system chain are cascaded on the circuit board. To minimize the risk, QucsStudio schematic simulations will be conducted, when possible.

## Ready-to-use SAW Bandpass Filters
### Best Choices
* [TAI-SAW TA0980A](https://www.taisaw.com/assets/PDF/TA0980A%20_Rev.4.0_.pdf)  (Center Frequency: 402 MHz, BW: 4 MHz)
* [TAI-SAW TA2320A](https://www.rfmw.com/datasheets/taisaw/ta2320a%20_rev.1.0_.pdf)  (Center Frequency: 437.5 MHz, BW: 5 MHz)

### Alternatives for Upper Band
* [TAI-SAW TA1408A](https://www.taisaw.com/assets/PDF/TA1408A%20_Rev.1.0_.pdf)  (Center Frequency: 435 MHz, BW: 10 MHz)
* [SHOULDER HDF434A1S6](https://www.rfmw.com/datasheets/shoulder/hdf434a1-s6.pdf) (Center Frequency: 434 MHz, BW: 10 MHz)

## The Simplest Possible Homemade FM Notch Filter

## Lumped Element Filter Designs by QucsStudio Filter Synthesis Tool





