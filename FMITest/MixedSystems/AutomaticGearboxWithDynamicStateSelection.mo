within FMITest.MixedSystems;
package AutomaticGearboxWithDynamicStateSelection
  "Same as model AutomaticGearbox, but with the additional difficulty, that dynamic state selection takes place during simulation"
  extends Modelica.Icons.ExamplesPackage;
  model Reference "Reference solution in pure Modelica"
    extends FMITest.MixedSystems.AutomaticGearbox.Reference(
      inertia1(stateSelect=StateSelect.default),
      C1(stateSelect=StateSelect.default),
      C2(stateSelect=StateSelect.default));
    annotation (experiment(StopTime=10));
  end Reference;

  model WithFMUsReference
    "Reference solution in pure Modelica using exactly the same structuring as in Model WithFMUs"
    extends Modelica.Icons.Example;

    FMUModels.AutomaticGear automaticGear
      annotation (Placement(transformation(extent={{-18,0},{2,20}})));
    FMUModels.ECU eCU annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-8,50})));
  equation
    connect(eCU.C2, automaticGear.c2) annotation (Line(
        points={{-12,39},{-12,22}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(eCU.B1, automaticGear.b1) annotation (Line(
        points={{-4,39},{-4,22}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(automaticGear.v, eCU.speed) annotation (Line(
        points={{5,10},{30,10},{30,72},{-8,72},{-8,62},{-8,62}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(eCU.C1, automaticGear.c1) annotation (Line(
        points={{-16,39},{-16,30},{-18,30},{-18,22}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(eCU.B2, automaticGear.b2) annotation (Line(
        points={{0,39},{0,32},{2,32},{2,22}},
        color={255,0,255},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), experiment(StopTime=10));
  end WithFMUsReference;

  model WithFMUs "Solution with FMUs"
    extends Modelica.Icons.Example;

    FMUModels.AutomaticGear automaticGear
      annotation (Placement(transformation(extent={{-20,0},{0,20}})));
    FMUModels.ECU eCU annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-10,50})));
  equation
    connect(eCU.C2, automaticGear.c2) annotation (Line(
        points={{-14,39},{-14,22}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(eCU.B1, automaticGear.b1) annotation (Line(
        points={{-6,39},{-6,22}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(automaticGear.v, eCU.speed) annotation (Line(
        points={{3,10},{28,10},{28,72},{-10,72},{-10,62}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(eCU.C1, automaticGear.c1) annotation (Line(
        points={{-18,39},{-18,30},{-20,30},{-20,22}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(eCU.B2, automaticGear.b2) annotation (Line(
        points={{-2,39},{-2,32},{0,32},{0,22}},
        color={255,0,255},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), experiment(StopTime=10));
  end WithFMUs;

  package FMUModels "For all models in this package an FMU must be generated"
    extends Modelica.Icons.Package;

    model AutomaticGear
      extends FMITest.MixedSystems.AutomaticGearbox.FMUModels.AutomaticGear(
        inertia1(stateSelect=StateSelect.default),
        C1(stateSelect=StateSelect.default),
        C2(stateSelect=StateSelect.default));
    end AutomaticGear;

    model ECU
      "Very simple electronic control unit to control clutches C1, C2 and brakes B1, B2"

      import SI = Modelica.SIunits;
      parameter SI.Time t_start=1
        "Time instant when the driver switches from 'N' to 'D', i.e., when the car starts driving";
      parameter SI.Velocity v_up_12=10
        "Velocity to switch from gear 1 into gear 2";
      parameter SI.Velocity v_up_23=20
        "Velocity to switch from gear 2 into gear 3";
      Modelica.Blocks.Interfaces.BooleanOutput C1 annotation (Placement(
            transformation(extent={{100,-90},{120,-70}}, rotation=0)));
      Modelica.Blocks.Interfaces.BooleanOutput C2 annotation (Placement(
            transformation(extent={{100,-50},{120,-30}}, rotation=0)));
      Modelica.Blocks.Interfaces.BooleanOutput B1 annotation (Placement(
            transformation(extent={{100,30},{120,50}}, rotation=0)));
      Modelica.Blocks.Interfaces.BooleanOutput B2 annotation (Placement(
            transformation(extent={{100,70},{120,90}}, rotation=0)));
      Modelica.Blocks.Interfaces.RealInput speed annotation (Placement(
            transformation(extent={{-140,-20},{-100,20}}, rotation=0)));
      Integer gear;

    equation
      gear = if time < t_start then 0 else if speed < v_up_12 then 1 else if
        speed < v_up_23 then 2 else 3;

      if gear == 0 then
        C1 = false;
        C2 = false;
        B1 = false;
        B2 = false;
      elseif gear == 1 then
        C1 = true;
        C2 = false;
        B1 = true;
        B2 = false;
      elseif gear == 2 then
        C1 = true;
        C2 = false;
        B1 = false;
        B2 = true;
      else
        C1 = true;
        C2 = true;
        B1 = false;
        B2 = false;
      end if;
      annotation (Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics), Icon(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={
            Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-60,48},{40,48},{16,-11},{-86,-10},{-60,48}},
              lineColor={160,160,164},
              fillColor={160,160,164},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-86,-10},{16,-11},{16,-37},{-86,-37},{-86,-10}},
              lineColor={128,128,128},
              fillColor={128,128,128},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{16,-11},{40,48},{40,27},{16,-37},{16,-11}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-122,-107},{113,-180}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              textString="%name"),
            Text(
              extent={{33,95},{96,63}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              textString="B2"),
            Text(
              extent={{33,54},{97,22}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              textString="B1"),
            Text(
              extent={{32,-17},{97,-51}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              textString="C2"),
            Text(
              extent={{32,-60},{97,-94}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              textString="C1"),
            Text(
              extent={{-82,-59},{26,-91}},
              lineColor={135,135,135},
              fillColor={235,245,255},
              fillPattern=FillPattern.Solid,
              textString="to FMU")}));
    end ECU;
  end FMUModels;
  annotation (preferredView="Info");
end AutomaticGearboxWithDynamicStateSelection;
