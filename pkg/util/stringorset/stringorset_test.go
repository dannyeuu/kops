/*
Copyright 2017 The Kubernetes Authors.

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

package stringorset

import (
	"encoding/json"
	"testing"

	"k8s.io/klog/v2"
)

func TestRoundTrip(t *testing.T) {
	grid := []struct {
		Value StringOrSet
		JSON  string
	}{
		{
			Value: String("a"),
			JSON:  "\"a\"",
		},
		{
			Value: Of("a"),
			JSON:  "\"a\"",
		},
		{
			Value: Set([]string{"a"}),
			JSON:  "[\"a\"]",
		},
		{
			Value: Of("a", "b"),
			JSON:  "[\"a\",\"b\"]",
		},
		{
			Value: Set([]string{"a", "b"}),
			JSON:  "[\"a\",\"b\"]",
		},
		{
			Value: Of(),
			JSON:  "[]",
		},
		{
			Value: Set(nil),
			JSON:  "[]",
		},
	}
	for _, g := range grid {
		actualJSON, err := json.Marshal(g.Value)
		if err != nil {
			t.Errorf("error encoding StringOrSlice %s to json: %v", g.Value, err)
		}

		klog.V(8).Infof("marshalled %s -> %q", g.Value, actualJSON)

		if g.JSON != string(actualJSON) {
			t.Errorf("Unexpected JSON encoding.  Actual=%q, Expected=%q", string(actualJSON), g.JSON)
		}

		parsed := &StringOrSet{}
		err = json.Unmarshal([]byte(g.JSON), parsed)
		if err != nil {
			t.Errorf("error decoding StringOrSlice %s to json: %v", g.JSON, err)
		}

		if !parsed.Equal(g.Value) {
			t.Errorf("Unexpected JSON decoded value for %q.  Actual=%v, Expected=%v", g.JSON, parsed, g.Value)
		}

	}
}
