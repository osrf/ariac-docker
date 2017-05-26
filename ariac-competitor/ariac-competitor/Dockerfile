FROM ariac-competitor-clean:latest

COPY ./build_team_system.bash /
RUN chmod 755 /build_team_system.bash
COPY ./run_team_system.bash /
RUN chmod 755 /run_team_system.bash
COPY ./run_team_system_with_delay.bash /
RUN chmod 755 /run_team_system_with_delay.bash

RUN /build_team_system.bash
ENTRYPOINT ["/bin/bash"]
