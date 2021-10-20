version 1.0

struct RuntimeEnvironment {
    String docker
    String? singularity
    String? conda
}

workflow test_docker_input {
    meta {
        default_docker: 'ubuntu:latest'
        default_singularity: 'docker://ubuntu:latest'
        default_conda: 'encode-chip-seq-pipeline'
    }
    input {
        #String default_docker = 'ubuntu:16.04'
        #String default_singularity = 'docker://ubuntu:16.04'
        #String default_conda = 'encode-chip-seq-pipeline-python2'
        RuntimeEnvironment runtime_environment = {
            'docker': 'ubuntu:16.04',
            'singularity': 'docker://ubuntu:16.04',
            'conda': 'encode-chip-seq-pipeline-python2'
        }
    }
    call t1 as t1_all { input:
        #docker = default_docker,
        #singularity = default_singularity,
        #conda = default_conda,
        runtime_environment = runtime_environment,
    }
}

task t1 {
    input {
        #String? docker
        #String? singularity
        #String? conda
        RuntimeEnvironment runtime_environment
    }
    command {
        cat /etc/os-release > os.ver
        echo $(which python) > python.ver
        echo "waiting..."
        sleep 100
        echo "all done."
    }
    output {
        File os_ver = "os.ver"
        File python_ver = "python.ver"
    }

    runtime {
        docker: runtime_environment.docker
        singularity: runtime_environment.singularity
        conda: runtime_environment.conda
    }
}
