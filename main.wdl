version 1.0

workflow CryoEM2DAnalysis {
  input {
    String parametersFile
  }

  call Relion_2D_Classification {

  }
}

task Relion_2D_Classification {
  input {

  }

  command {
    relion_refine
  }

  output {
    // 平均值
    File classAverages = 'class_averages.mrc'
    // 运动校正
    File motionCorrections = 'motion_corrections.mrc'
  }

  runtime {
    docker: ${docker}
    gpuType: 'Tesla-T4'
    gpuCount: 2
    memory: '256G'
  }
}