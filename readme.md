# Experiment with big ip rules combined with [TestTcl](https://github.com/landro/TesTcl)
[![CI](https://github.com/chrisns/bigip-irule-demo/actions/workflows/ci.yaml/badge.svg)](https://github.com/chrisns/bigip-irule-demo/actions/workflows/ci.yaml)

> Simple proof of concept using tcl to define a rule with TCL for a F5 BIG-IP appliance with tests

Test:

```bash
docker run -it --rm -v ${PWD}:/app ghcr.io/chrisns/testcl:latest
```