import logging
from neutronclient.neutron import client

auth_url = "http://192.168.20.36:5000/v2.0"

logging.basicConfig(level=logging.DEBUG)
neutron = client.Client('2.0', username="myuser", password="mypassword",
                        tenant_name="mytenant", auth_url=auth_url)

data = {"subnet": {"allocation_pools": [
                     {"start": "192.168.20.14", "end": "192.168.20.15"},
                     {"start": "192.168.20.9", "end": "192.168.20.10"}]
                 }
      }

try:
    # update_subnet expects subnet_id and data
    neutron.update_subnet("1d6ca5d0-9519-4d3c-8805-a66c5d72b6f9", data)
    logging.info("Subnet pool updated successfully.")
except Exception as ex:
logging.error("Error, while updating the subnet pool.")
