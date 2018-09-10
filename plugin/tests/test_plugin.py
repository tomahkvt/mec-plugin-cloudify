########
# Copyright (c) 2014 GigaSpaces Technologies Ltd. All rights reserved
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#        http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
#    * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    * See the License for the specific language governing permissions and
#    * limitations under the License.


from os import path
import unittest

from cloudify.test_utils import workflow_test


class TestPlugin(unittest.TestCase):

    @workflow_test(path.join('blueprint', 'blueprint.yaml'),
                   resources_to_copy=[(path.join('../', '../',
                                                 'plugin.yaml'),
                                       'plugin')],
                   inputs={'test_input': 'new_test_input'})
    def test_my_task(self, cfy_local):
        # execute install workflow
        """

        :param cfy_local:
        """
        cfy_local.execute('install', task_retries=0)

        # extract single node instance
        instance = cfy_local.storage.get_node_instances()[0]

        cfy_local.execute('uninstall', task_retries=0)
