within EU_CleanSky.EDS.SafetyLib.Sources;
model PermanentPower "A permanent power source (energy storage)."
  extends Interfaces.PowerSource(final showPolarity=true, redeclare model
      Dipole =
        Interfaces.ReversibleDipole (redeclare model Dipole =
            Internal.PolarisedPermanentPower));
end PermanentPower;
