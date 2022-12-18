/*
Copyright 2019 The Kubernetes Authors.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

package nodetasks

import (
	"reflect"
	"testing"

	"k8s.io/kops/upup/pkg/fi"
)

func TestLoadImageTask_Deps(t *testing.T) {
	l := &LoadImageTask{}

	tasks := make(map[string]fi.NodeupTask)
	tasks["LoadImageTask1"] = &LoadImageTask{}
	tasks["FileTask1"] = &File{}
	tasks["ServiceDocker"] = &Service{Name: "docker.service"}
	tasks["Service2"] = &Service{Name: "two.service"}

	deps := l.GetDependencies(tasks)
	expected := []fi.NodeupTask{tasks["ServiceDocker"]}
	if !reflect.DeepEqual(expected, deps) {
		t.Fatalf("unexpected deps.  expected=%v, actual=%v", expected, deps)
	}
}
