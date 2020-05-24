FROM ariac/ariac3-competitor-base-melodic:latest

COPY ./fast_rl_ws /fast_rl_ws
COPY ./build_team_system.bash /
RUN chmod 755 /build_team_system.bash
RUN /build_team_system.bash

COPY ./run_team_system.bash /
RUN chmod 755 /run_team_system.bash
COPY ./run_team_system_with_delay.bash /
RUN chmod 755 /run_team_system_with_delay.bash

ENTRYPOINT ["/bin/bash"]
