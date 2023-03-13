[Mesh]
  type = MeshGeneratorMesh
  [file_mesh]
    type = FileMeshGenerator
    file = cylinder_within_cylinder.msh
  []
  [rotor_outer_surface_sideset]
    type = SideSetsBetweenSubdomainsGenerator
    input = file_mesh
    primary_block = 'rotor_volume'
    paired_block = 'vacuum_volume'
    new_boundary = 'rotor_outer_surface_sideset'
  []
  [stator_inner_surface_sideset]
    type = SideSetsBetweenSubdomainsGenerator
    input = rotor_outer_surface_sideset
    primary_block = 'stator_volume'
    paired_block = 'vacuum_volume'
    new_boundary = 'stator_inner_surface_sideset'
  []
[]

[Variables]
  [Temperature]
  []
[]

[ICs]
  [rotor_IC]
    type = ConstantIC
    variable = Temperature
    block = 'rotor_volume'
    value = 70 # K
  []
  [vacuum_IC]
    type = ConstantIC
    variable = Temperature 
    block = 'vacuum_volume'
    value = 70
  []
  [stator_IC]
    type = ConstantIC
    variable = Temperature 
    block = 'stator_volume'
    value = 300
  []
[]

[Kernels]
  [heat_conduction]
    type = HeatConduction
    variable = Temperature
  []
  [heat_conduction_time_derivative]
    type = HeatConductionTimeDerivative
    variable = Temperature
  []
[]

[GrayDiffuseRadiation]
  [vacuum_radiation]
    boundary = 'stator_inner_surface_sideset rotor_outer_surface_sideset'
    emissivity = '0.03 0.03'
    n_patches = '1 1'
    temperature = Temperature
    ray_tracing_face_type = 'GAUSS'
  []
[]

[Materials]
  [thermal_rotor]
    type = HeatConductionMaterial
    thermal_conductivity = 100.0 # W / (m K)
    specific_heat = 900.0 # J / (kg K)
    block = 'rotor_volume'
  []
  [thermal_vacuum]
    type = HeatConductionMaterial
    thermal_conductivity = 0.
    specific_heat = 1000.0
    block = 'vacuum_volume'
  []
  [thermal_stator]
    type = HeatConductionMaterial
    thermal_conductivity = 225.0
    specific_heat = 900.0
    block = 'stator_volume'
  []
  [density_rotor_stator]
    type = GenericConstantMaterial
    prop_names = 'density'
    prop_values = 2710.0 # kg / m^3
    block = 'rotor_volume stator_volume'
  []
  [density_air]
    type = GenericConstantMaterial
    prop_names = 'density'
    prop_values = 0.00021773 # kg / m^3
    block = 'vacuum_volume'
  [][]

[BCs]
 [temperature_stator]
   type = DirichletBC
   variable = Temperature
   value = 300
   boundary = 'stator_outer_surface'
 []
[]

[Executioner]
  type = Transient
  end_time = 43200
  dt = 3600
[]

[Outputs]
  exodus = true
  [rays]
    type = RayTracingExodus
    study = ray_study_uo_vacuum_radiation
    execute_on = 'INITIAL'
  []
[]