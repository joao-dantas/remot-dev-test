# remot-dev-test project

This project uses Quarkus, the Supersonic Subatomic Java Framework.

If you want to learn more about Quarkus, please visit its website: https://quarkus.io/ .

## Remote Dev - Issue

This project tries to reproduce the issue https://github.com/quarkusio/quarkus/issues/10998 with the remote-dev plugin from quarkus 1.6.1 version. (https://quarkus.io/guides/maven-tooling)

You can just run the following script to reproduce the steps:
```
./run-dev-env.sh
```

The expected is to see the following exception on the remote container:

```
2020-07-26 20:07:00,124 ERROR [io.qua.ver.htt.run.dev.RemoteSyncHandler] (vert.x-eventloop-thread-6) Connect failed: java.lang.NullPointerException
	at io.quarkus.deployment.dev.IsolatedRemoteDevModeMain.createHashes(IsolatedRemoteDevModeMain.java:298)
	at io.quarkus.deployment.dev.RuntimeUpdatesProcessor.syncState(RuntimeUpdatesProcessor.java:204)
	at io.quarkus.vertx.http.runtime.devmode.RemoteSyncHandler$6.handle(RemoteSyncHandler.java:182)
	at io.quarkus.vertx.http.runtime.devmode.RemoteSyncHandler$6.handle(RemoteSyncHandler.java:168)
	at io.vertx.core.http.HttpServerRequest.lambda$bodyHandler$0(HttpServerRequest.java:216)
	at io.vertx.core.http.impl.HttpServerRequestImpl.onEnd(HttpServerRequestImpl.java:521)
	at io.vertx.core.http.impl.HttpServerRequestImpl.lambda$pendingQueue$1(HttpServerRequestImpl.java:115)
	at io.vertx.core.streams.impl.InboundBuffer.handleEvent(InboundBuffer.java:237)
	at io.vertx.core.streams.impl.InboundBuffer.drain(InboundBuffer.java:224)
	at io.vertx.core.streams.impl.InboundBuffer.lambda$fetch$0(InboundBuffer.java:277)
	at io.vertx.core.impl.ContextImpl.executeTask(ContextImpl.java:366)
	at io.vertx.core.impl.EventLoopContext.lambda$executeAsync$0(EventLoopContext.java:38)
	at io.netty.util.concurrent.AbstractEventExecutor.safeExecute(AbstractEventExecutor.java:164)
	at io.netty.util.concurrent.SingleThreadEventExecutor.runAllTasks(SingleThreadEventExecutor.java:472)
	at io.netty.channel.nio.NioEventLoop.run(NioEventLoop.java:500)
	at io.netty.util.concurrent.SingleThreadEventExecutor$4.run(SingleThreadEventExecutor.java:989)
	at io.netty.util.internal.ThreadExecutorMap$2.run(ThreadExecutorMap.java:74)
	at io.netty.util.concurrent.FastThreadLocalRunnable.run(FastThreadLocalRunnable.java:30)
	at java.base/java.lang.Thread.run(Thread.java:834)
```

The client log is:

```
2020-07-26 17:52:56,415 ERROR [io.qua.ver.htt.dep.dev.HttpRemoteDevClient] (Remote dev client thread) Remote dev request failed: java.io.IOException: Server did not start a remote dev session
        at io.quarkus.vertx.http.deployment.devmode.HttpRemoteDevClient.doConnect(HttpRemoteDevClient.java:65)
        at io.quarkus.vertx.http.deployment.devmode.HttpRemoteDevClient.access$200(HttpRemoteDevClient.java:27)
        at io.quarkus.vertx.http.deployment.devmode.HttpRemoteDevClient$Session.run(HttpRemoteDevClient.java:163)
        at java.base/java.lang.Thread.run(Thread.java:834)

```
