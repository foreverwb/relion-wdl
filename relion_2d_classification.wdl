version 1.0

workflow CryoEM2DAnalysis {
  File Particles
  Int pool

  call Relion_2D_Classification {
    input:
      Particles = Particles
      pool = pool
  }
}

task Relion_2D_Classification {
  input {
    File Particles
    Int pool = 100
    Int pad = 2
    Int iter = 25
    Int tau2_fudge = 2
    Int particle_diameter = 360
    Int K = 200
    Int oversampling = 1
    Int psi_step = 6
    Int offset_range = 5
    Int offset_step = 2
    Int j = 4
    Int random_seed = 0
    String scratch_dir
    String pipeline_control
    Boolean dont_combine_weights_via_disc
    Boolean ctf
    Boolean flatten_solvent
    Boolean zero_mask
    Boolean norm
    Boolean scale
    String docker_image
  }

  command {
    relion_refine --i ${Particles} \
    --dont_combine_weights_via_disc ${dont_combine_weights_via_disc} \
    --scratch_dir ${scratch_dir} \
    --pool ${pool} \
    --pad ${pad} \
    --iter ${iter} \
    --tau2_fudge ${tau2_fudge} \
    --particle_diameter ${particle_diameter} \
    --K ${K} \
    --flatten_solvent ${flatten_solvent} \
    --zero_mask ${zero_mask} \
    --oversampling ${oversampling} \
    --psi_step ${psi_step} \
    --offset_range ${offset_range} \
    --offset_step ${offset_step} \
    --norm ${norm} \
    --scale ${scale} \
    --pipeline_control ${pipeline_control} \
    --random_seed ${random_seed} \
    --j ${j}
    --o 
  }

  output {
    // 平均值
    File classAverages = 'class_averages.mrc'
    // 运动校正
    File motionCorrections = 'motion_corrections.mrc'
  }

  runtime {
    docker: docker_image
    gpuType: 'Tesla-T4'
    gpuCount: 2
    memory: '256G'
  }
}