/*
Copyright The Kubernetes Authors.

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

// Code generated by protoc-gen-go-grpc. DO NOT EDIT.

package v1

import (
	context "context"

	grpc "google.golang.org/grpc"
	codes "google.golang.org/grpc/codes"
	status "google.golang.org/grpc/status"
)

// This is a compile-time assertion to ensure that this generated file
// is compatible with the grpc package it is being compiled against.
// Requires gRPC-Go v1.32.0 or later.
const _ = grpc.SupportPackageIsVersion7

// CallbackServiceClient is the client API for CallbackService service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://pkg.go.dev/google.golang.org/grpc/?tab=doc#ClientConn.NewStream.
type CallbackServiceClient interface {
	// Answers challenges to cross-check bootstrap requests.
	Challenge(ctx context.Context, in *ChallengeRequest, opts ...grpc.CallOption) (*ChallengeResponse, error)
}

type callbackServiceClient struct {
	cc grpc.ClientConnInterface
}

func NewCallbackServiceClient(cc grpc.ClientConnInterface) CallbackServiceClient {
	return &callbackServiceClient{cc}
}

func (c *callbackServiceClient) Challenge(ctx context.Context, in *ChallengeRequest, opts ...grpc.CallOption) (*ChallengeResponse, error) {
	out := new(ChallengeResponse)
	err := c.cc.Invoke(ctx, "/kops.bootstrap.v1.CallbackService/Challenge", in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

// CallbackServiceServer is the server API for CallbackService service.
// All implementations must embed UnimplementedCallbackServiceServer
// for forward compatibility
type CallbackServiceServer interface {
	// Answers challenges to cross-check bootstrap requests.
	Challenge(context.Context, *ChallengeRequest) (*ChallengeResponse, error)
	mustEmbedUnimplementedCallbackServiceServer()
}

// UnimplementedCallbackServiceServer must be embedded to have forward compatible implementations.
type UnimplementedCallbackServiceServer struct {
}

func (UnimplementedCallbackServiceServer) Challenge(context.Context, *ChallengeRequest) (*ChallengeResponse, error) {
	return nil, status.Errorf(codes.Unimplemented, "method Challenge not implemented")
}
func (UnimplementedCallbackServiceServer) mustEmbedUnimplementedCallbackServiceServer() {}

// UnsafeCallbackServiceServer may be embedded to opt out of forward compatibility for this service.
// Use of this interface is not recommended, as added methods to CallbackServiceServer will
// result in compilation errors.
type UnsafeCallbackServiceServer interface {
	mustEmbedUnimplementedCallbackServiceServer()
}

func RegisterCallbackServiceServer(s grpc.ServiceRegistrar, srv CallbackServiceServer) {
	s.RegisterService(&CallbackService_ServiceDesc, srv)
}

func _CallbackService_Challenge_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(ChallengeRequest)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(CallbackServiceServer).Challenge(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: "/kops.bootstrap.v1.CallbackService/Challenge",
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(CallbackServiceServer).Challenge(ctx, req.(*ChallengeRequest))
	}
	return interceptor(ctx, in, info, handler)
}

// CallbackService_ServiceDesc is the grpc.ServiceDesc for CallbackService service.
// It's only intended for direct use with grpc.RegisterService,
// and not to be introspected or modified (even as a copy)
var CallbackService_ServiceDesc = grpc.ServiceDesc{
	ServiceName: "kops.bootstrap.v1.CallbackService",
	HandlerType: (*CallbackServiceServer)(nil),
	Methods: []grpc.MethodDesc{
		{
			MethodName: "Challenge",
			Handler:    _CallbackService_Challenge_Handler,
		},
	},
	Streams:  []grpc.StreamDesc{},
	Metadata: "kops/bootstrap/v1/bootstrap.proto",
}
