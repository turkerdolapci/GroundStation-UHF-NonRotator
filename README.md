# GroundStation-UHF-NonRotator
This repo contains a non-rotator UHF ground station setup to receive LEO satellite signals.

## Scope
The final products will be presented along with the analysis steps, to the utmost.
Shared work (and used tools) will include but will not be limited with:
- Block diagrams (draw.io),
- System analyses (GNU Octave),
- RF front-ends (QucsStudio),
- Antennas (4Nec2),
- Circuit schematics and layouts (KiCad).
  
Objective of this work is not only sharing the information but also to experience maintaining a repo. It's my first repo, YAY!

## License
The content of this project, (such as; informative technical notes, conceptual drawings, analysis scripts and resulting visuals, design and simulation schematics, simulation results, circuit layouts, etc.) is licensed under the [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/) license. This project is not a software development project, but rather a problem analysis and system design project.

## Directories
### LinkBudget
Includes a conceptual drawing and an analysis script to calculate; 
- The distance between the ground station and the satellite,
- The path loss between the ground station and the satellite,
- The isoflux pattern to build an antenna to maintain the link margin in all elevation positions.

### AntennaCircuit
Includes two different conceptual drawings of 4-way RF quadrature power splitters, using quadrature hybrids and baluns.
