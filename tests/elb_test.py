# pylint: disable=missing-docstring, line-too-long, protected-access, E1101, C0202, E0602, W0109
import unittest
from runner import Runner


class TestE2E(unittest.TestCase):
    @classmethod
    def setUpClass(self):
        self.snippet = """

            provider "aws" {
              region = "eu-west-2"
              skip_credentials_validation = true
              skip_get_ec2_platforms = true
            }

            module "elb" {
              source = "./mymodule"

              providers = {
                aws = "aws"
              }

              vpc_id            = "vpc-abcd0123"
              subnet_list       = ["subnet-abcd0123"]
              security_groups   = ["sg-abcd1234"]
              instance_profile  = "iip-assoc-00000011111111222"
              launch_config     = "test-lg-123456"
              TCPPorts          = ["443","135","1433"]
            }
        """
        self.result = Runner(self.snippet).result

    def test_root_destroy(self):
        self.assertEqual(self.result["destroy"], False)
