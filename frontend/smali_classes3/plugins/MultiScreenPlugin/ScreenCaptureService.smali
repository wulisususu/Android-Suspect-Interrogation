.class public Lplugins/MultiScreenPlugin/ScreenCaptureService;
.super Landroid/app/Service;
.source "ScreenCaptureService.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lplugins/MultiScreenPlugin/ScreenCaptureService$LocalBinder;,
        Lplugins/MultiScreenPlugin/ScreenCaptureService$ClientHandler;
    }
.end annotation


# static fields
.field private static final CAPTURE_FPS:I = 0x5

.field private static final CAPTURE_INTERVAL:I = 0xc8

.field private static final MJPEG_PORT:I = 0xd9fd

.field private static final TAG:Ljava/lang/String; = "ScreenCaptureService"


# instance fields
.field private final binder:Landroid/os/IBinder;

.field private broadcastExecutor:Ljava/util/concurrent/ExecutorService;

.field private captureOptimizer:Lplugins/MultiScreenPlugin/CaptureOptimizer;

.field private captureThread:Ljava/lang/Thread;

.field private clients:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lplugins/MultiScreenPlugin/ScreenCaptureService$ClientHandler;",
            ">;"
        }
    .end annotation
.end field

.field private isRunning:Ljava/util/concurrent/atomic/AtomicBoolean;

.field private serverSocket:Ljava/net/ServerSocket;

.field private serverThread:Ljava/lang/Thread;

.field private targetWebView:Landroid/webkit/WebView;

.field private targetWindow:Landroid/view/Window;


# direct methods
.method public static synthetic $r8$lambda$9pDil79JEsuy43QthPJzMEYCa-0(Lplugins/MultiScreenPlugin/ScreenCaptureService;)V
    .locals 0

    invoke-direct {p0}, Lplugins/MultiScreenPlugin/ScreenCaptureService;->lambda$startCaptureThread$2()V

    return-void
.end method

.method public static synthetic $r8$lambda$PuTjhqSfuSO9aKKKW8Ztb4pf6Yk(Lplugins/MultiScreenPlugin/ScreenCaptureService;)V
    .locals 0

    invoke-direct {p0}, Lplugins/MultiScreenPlugin/ScreenCaptureService;->lambda$startMjpegServer$0()V

    return-void
.end method

.method public static synthetic $r8$lambda$TdWhJU5dhqyA7aUoCk-5h4wseE8(Lplugins/MultiScreenPlugin/ScreenCaptureService;)V
    .locals 0

    invoke-direct {p0}, Lplugins/MultiScreenPlugin/ScreenCaptureService;->lambda$startCaptureThread$1()V

    return-void
.end method

.method static bridge synthetic -$$Nest$fgetbroadcastExecutor(Lplugins/MultiScreenPlugin/ScreenCaptureService;)Ljava/util/concurrent/ExecutorService;
    .locals 0

    iget-object p0, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService;->broadcastExecutor:Ljava/util/concurrent/ExecutorService;

    return-object p0
.end method

.method static bridge synthetic -$$Nest$mbroadcastFrame(Lplugins/MultiScreenPlugin/ScreenCaptureService;[B)V
    .locals 0

    invoke-direct {p0, p1}, Lplugins/MultiScreenPlugin/ScreenCaptureService;->broadcastFrame([B)V

    return-void
.end method

.method public constructor <init>()V
    .locals 2

    .line 28
    invoke-direct {p0}, Landroid/app/Service;-><init>()V

    .line 37
    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    iput-object v0, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService;->isRunning:Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 38
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService;->clients:Ljava/util/List;

    .line 50
    new-instance v0, Lplugins/MultiScreenPlugin/ScreenCaptureService$LocalBinder;

    invoke-direct {v0, p0}, Lplugins/MultiScreenPlugin/ScreenCaptureService$LocalBinder;-><init>(Lplugins/MultiScreenPlugin/ScreenCaptureService;)V

    iput-object v0, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService;->binder:Landroid/os/IBinder;

    return-void
.end method

.method private broadcastFrame([B)V
    .locals 5

    iget-object v0, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService;->clients:Ljava/util/List;

    .line 256
    monitor-enter v0

    .line 257
    :try_start_0
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    iget-object v2, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService;->clients:Ljava/util/List;

    .line 258
    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_0
    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lplugins/MultiScreenPlugin/ScreenCaptureService$ClientHandler;

    .line 259
    invoke-virtual {v3, p1}, Lplugins/MultiScreenPlugin/ScreenCaptureService$ClientHandler;->sendFrame([B)Z

    move-result v4

    if-nez v4, :cond_0

    .line 260
    invoke-interface {v1, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_1
    iget-object p1, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService;->clients:Ljava/util/List;

    .line 264
    invoke-interface {p1, v1}, Ljava/util/List;->removeAll(Ljava/util/Collection;)Z

    .line 265
    monitor-exit v0

    return-void

    :catchall_0
    move-exception p1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p1
.end method

.method private configureWebViewForCapture(Landroid/webkit/WebView;)V
    .locals 1

    if-eqz p1, :cond_0

    const-string p1, "ScreenCaptureService"

    const-string v0, "WebView\u5df2\u914d\u7f6e\u4e3a\u8f6f\u4ef6\u6e32\u67d3\u6a21\u5f0f\u4ee5\u652f\u6301\u622a\u56fe"

    .line 112
    invoke-static {p1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    return-void
.end method

.method public static getMjpegPort()I
    .locals 1

    const v0, 0xd9fd

    return v0
.end method

.method private synthetic lambda$startCaptureThread$1()V
    .locals 5

    const-string v0, "ScreenCaptureService"

    :try_start_0
    iget-object v1, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService;->targetWindow:Landroid/view/Window;

    if-nez v1, :cond_1

    iget-object v2, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService;->targetWebView:Landroid/webkit/WebView;

    .line 210
    invoke-virtual {v2}, Landroid/webkit/WebView;->getContext()Landroid/content/Context;

    move-result-object v2

    .line 211
    :goto_0
    instance-of v3, v2, Landroid/content/ContextWrapper;

    if-eqz v3, :cond_1

    .line 212
    instance-of v3, v2, Landroid/app/Activity;

    if-eqz v3, :cond_0

    .line 213
    check-cast v2, Landroid/app/Activity;

    invoke-virtual {v2}, Landroid/app/Activity;->getWindow()Landroid/view/Window;

    move-result-object v1

    goto :goto_1

    .line 216
    :cond_0
    check-cast v2, Landroid/content/ContextWrapper;

    invoke-virtual {v2}, Landroid/content/ContextWrapper;->getBaseContext()Landroid/content/Context;

    move-result-object v2

    goto :goto_0

    :cond_1
    :goto_1
    if-nez v1, :cond_2

    const-string v1, "\u65e0\u6cd5\u83b7\u53d6Window\uff0cPixelCopy\u4e0d\u53ef\u7528"

    .line 220
    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    return-void

    :cond_2
    iget-object v2, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService;->captureOptimizer:Lplugins/MultiScreenPlugin/CaptureOptimizer;

    iget-object v3, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService;->targetWebView:Landroid/webkit/WebView;

    .line 223
    new-instance v4, Lplugins/MultiScreenPlugin/ScreenCaptureService$1;

    invoke-direct {v4, p0}, Lplugins/MultiScreenPlugin/ScreenCaptureService$1;-><init>(Lplugins/MultiScreenPlugin/ScreenCaptureService;)V

    invoke-virtual {v2, v1, v3, v4}, Lplugins/MultiScreenPlugin/CaptureOptimizer;->captureOptimized(Landroid/view/Window;Landroid/view/View;Lplugins/MultiScreenPlugin/CaptureOptimizer$PixelCopyCallback;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_2

    :catch_0
    move-exception v1

    const-string v2, "\u622a\u56fe\u5931\u8d25"

    .line 236
    invoke-static {v0, v2, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :goto_2
    return-void
.end method

.method private synthetic lambda$startCaptureThread$2()V
    .locals 3

    :goto_0
    iget-object v0, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService;->isRunning:Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 201
    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Thread;->isInterrupted()Z

    move-result v0

    if-nez v0, :cond_1

    :try_start_0
    iget-object v0, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService;->targetWebView:Landroid/webkit/WebView;

    if-eqz v0, :cond_0

    .line 205
    new-instance v1, Lplugins/MultiScreenPlugin/ScreenCaptureService$$ExternalSyntheticLambda2;

    invoke-direct {v1, p0}, Lplugins/MultiScreenPlugin/ScreenCaptureService$$ExternalSyntheticLambda2;-><init>(Lplugins/MultiScreenPlugin/ScreenCaptureService;)V

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->post(Ljava/lang/Runnable;)Z

    :cond_0
    const-wide/16 v0, 0xc8

    .line 240
    invoke-static {v0, v1}, Ljava/lang/Thread;->sleep(J)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    const-string v1, "ScreenCaptureService"

    const-string v2, "\u622a\u56fe\u7ebf\u7a0b\u5f02\u5e38"

    .line 245
    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_0

    .line 242
    :catch_1
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Thread;->interrupt()V

    :cond_1
    return-void
.end method

.method private synthetic lambda$startMjpegServer$0()V
    .locals 4

    .line 129
    :try_start_0
    new-instance v0, Ljava/net/ServerSocket;

    const v1, 0xd9fd

    invoke-direct {v0, v1}, Ljava/net/ServerSocket;-><init>(I)V

    iput-object v0, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService;->serverSocket:Ljava/net/ServerSocket;

    const-string v0, "ScreenCaptureService"

    const-string v1, "MJPEG\u670d\u52a1\u5668\u542f\u52a8\u5728\u7aef\u53e3: 55805"

    .line 130
    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    :goto_0
    iget-object v0, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService;->isRunning:Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 132
    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService;->serverSocket:Ljava/net/ServerSocket;

    invoke-virtual {v0}, Ljava/net/ServerSocket;->isClosed()Z

    move-result v0
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1

    if-nez v0, :cond_1

    :try_start_1
    iget-object v0, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService;->serverSocket:Ljava/net/ServerSocket;

    .line 134
    invoke-virtual {v0}, Ljava/net/ServerSocket;->accept()Ljava/net/Socket;

    move-result-object v0

    .line 135
    new-instance v1, Lplugins/MultiScreenPlugin/ScreenCaptureService$ClientHandler;

    invoke-direct {v1, p0, v0}, Lplugins/MultiScreenPlugin/ScreenCaptureService$ClientHandler;-><init>(Lplugins/MultiScreenPlugin/ScreenCaptureService;Ljava/net/Socket;)V

    iget-object v2, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService;->clients:Ljava/util/List;

    .line 136
    monitor-enter v2
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0

    :try_start_2
    iget-object v3, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService;->clients:Ljava/util/List;

    .line 137
    invoke-interface {v3, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 138
    monitor-exit v2
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 139
    :try_start_3
    new-instance v2, Ljava/lang/Thread;

    invoke-direct {v2, v1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    invoke-virtual {v2}, Ljava/lang/Thread;->start()V

    const-string v1, "ScreenCaptureService"

    .line 140
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "\u65b0\u5ba2\u6237\u7aef\u8fde\u63a5: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/net/Socket;->getRemoteSocketAddress()Ljava/net/SocketAddress;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_0

    goto :goto_0

    :catchall_0
    move-exception v0

    .line 138
    :try_start_4
    monitor-exit v2
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    :try_start_5
    throw v0
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_0

    :catch_0
    move-exception v0

    :try_start_6
    iget-object v1, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService;->isRunning:Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 142
    invoke-virtual {v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v1

    if-eqz v1, :cond_0

    const-string v1, "ScreenCaptureService"

    const-string v2, "\u63a5\u53d7\u5ba2\u6237\u7aef\u8fde\u63a5\u5931\u8d25"

    .line 143
    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    :try_end_6
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_1

    goto :goto_0

    :catch_1
    move-exception v0

    const-string v1, "ScreenCaptureService"

    const-string v2, "\u542f\u52a8MJPEG\u670d\u52a1\u5668\u5931\u8d25"

    .line 148
    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :cond_1
    return-void
.end method

.method private startCaptureThread()V
    .locals 2

    .line 200
    new-instance v0, Ljava/lang/Thread;

    new-instance v1, Lplugins/MultiScreenPlugin/ScreenCaptureService$$ExternalSyntheticLambda0;

    invoke-direct {v1, p0}, Lplugins/MultiScreenPlugin/ScreenCaptureService$$ExternalSyntheticLambda0;-><init>(Lplugins/MultiScreenPlugin/ScreenCaptureService;)V

    invoke-direct {v0, v1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    iput-object v0, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService;->captureThread:Ljava/lang/Thread;

    .line 249
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    return-void
.end method

.method private startMjpegServer()V
    .locals 2

    iget-object v0, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService;->isRunning:Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 120
    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService;->isRunning:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x1

    .line 124
    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    .line 127
    new-instance v0, Ljava/lang/Thread;

    new-instance v1, Lplugins/MultiScreenPlugin/ScreenCaptureService$$ExternalSyntheticLambda1;

    invoke-direct {v1, p0}, Lplugins/MultiScreenPlugin/ScreenCaptureService$$ExternalSyntheticLambda1;-><init>(Lplugins/MultiScreenPlugin/ScreenCaptureService;)V

    invoke-direct {v0, v1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    iput-object v0, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService;->serverThread:Ljava/lang/Thread;

    .line 151
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    .line 154
    invoke-direct {p0}, Lplugins/MultiScreenPlugin/ScreenCaptureService;->startCaptureThread()V

    return-void
.end method

.method private stopMjpegServer()V
    .locals 3

    iget-object v0, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService;->isRunning:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    .line 161
    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    iget-object v0, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService;->clients:Ljava/util/List;

    .line 164
    monitor-enter v0

    :try_start_0
    iget-object v1, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService;->clients:Ljava/util/List;

    .line 165
    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lplugins/MultiScreenPlugin/ScreenCaptureService$ClientHandler;

    .line 166
    invoke-virtual {v2}, Lplugins/MultiScreenPlugin/ScreenCaptureService$ClientHandler;->close()V

    goto :goto_0

    :cond_0
    iget-object v1, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService;->clients:Ljava/util/List;

    .line 168
    invoke-interface {v1}, Ljava/util/List;->clear()V

    .line 169
    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    iget-object v0, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService;->serverSocket:Ljava/net/ServerSocket;

    if-eqz v0, :cond_1

    .line 172
    invoke-virtual {v0}, Ljava/net/ServerSocket;->isClosed()Z

    move-result v0

    if-nez v0, :cond_1

    :try_start_1
    iget-object v0, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService;->serverSocket:Ljava/net/ServerSocket;

    .line 174
    invoke-virtual {v0}, Ljava/net/ServerSocket;->close()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_1

    :catch_0
    move-exception v0

    const-string v1, "ScreenCaptureService"

    const-string v2, "\u5173\u95ed\u670d\u52a1\u5668socket\u5931\u8d25"

    .line 176
    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :cond_1
    :goto_1
    iget-object v0, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService;->serverThread:Ljava/lang/Thread;

    if-eqz v0, :cond_2

    .line 182
    invoke-virtual {v0}, Ljava/lang/Thread;->interrupt()V

    :cond_2
    iget-object v0, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService;->captureThread:Ljava/lang/Thread;

    if-eqz v0, :cond_3

    .line 185
    invoke-virtual {v0}, Ljava/lang/Thread;->interrupt()V

    :cond_3
    iget-object v0, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService;->broadcastExecutor:Ljava/util/concurrent/ExecutorService;

    if-eqz v0, :cond_4

    .line 189
    invoke-interface {v0}, Ljava/util/concurrent/ExecutorService;->isShutdown()Z

    move-result v0

    if-nez v0, :cond_4

    iget-object v0, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService;->broadcastExecutor:Ljava/util/concurrent/ExecutorService;

    .line 190
    invoke-interface {v0}, Ljava/util/concurrent/ExecutorService;->shutdown()V

    :cond_4
    const-string v0, "ScreenCaptureService"

    const-string v1, "MJPEG\u670d\u52a1\u5668\u5df2\u505c\u6b62"

    .line 193
    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    return-void

    :catchall_0
    move-exception v1

    .line 169
    :try_start_2
    monitor-exit v0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v1
.end method


# virtual methods
.method public onBind(Landroid/content/Intent;)Landroid/os/IBinder;
    .locals 0

    iget-object p1, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService;->binder:Landroid/os/IBinder;

    return-object p1
.end method

.method public onDestroy()V
    .locals 1

    .line 74
    invoke-direct {p0}, Lplugins/MultiScreenPlugin/ScreenCaptureService;->stopMjpegServer()V

    iget-object v0, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService;->broadcastExecutor:Ljava/util/concurrent/ExecutorService;

    if-eqz v0, :cond_0

    .line 75
    invoke-interface {v0}, Ljava/util/concurrent/ExecutorService;->isShutdown()Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService;->broadcastExecutor:Ljava/util/concurrent/ExecutorService;

    .line 76
    invoke-interface {v0}, Ljava/util/concurrent/ExecutorService;->shutdown()V

    .line 78
    :cond_0
    invoke-super {p0}, Landroid/app/Service;->onDestroy()V

    return-void
.end method

.method public onStartCommand(Landroid/content/Intent;II)I
    .locals 0

    .line 66
    new-instance p1, Lplugins/MultiScreenPlugin/CaptureOptimizer;

    invoke-direct {p1}, Lplugins/MultiScreenPlugin/CaptureOptimizer;-><init>()V

    iput-object p1, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService;->captureOptimizer:Lplugins/MultiScreenPlugin/CaptureOptimizer;

    .line 67
    invoke-static {}, Ljava/util/concurrent/Executors;->newSingleThreadExecutor()Ljava/util/concurrent/ExecutorService;

    move-result-object p1

    iput-object p1, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService;->broadcastExecutor:Ljava/util/concurrent/ExecutorService;

    .line 68
    invoke-direct {p0}, Lplugins/MultiScreenPlugin/ScreenCaptureService;->startMjpegServer()V

    const/4 p1, 0x1

    return p1
.end method

.method public setTargetWebView(Landroid/webkit/WebView;)V
    .locals 0

    iput-object p1, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService;->targetWebView:Landroid/webkit/WebView;

    .line 87
    invoke-direct {p0, p1}, Lplugins/MultiScreenPlugin/ScreenCaptureService;->configureWebViewForCapture(Landroid/webkit/WebView;)V

    return-void
.end method

.method public setWindow(Landroid/view/Window;)V
    .locals 0

    iput-object p1, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService;->targetWindow:Landroid/view/Window;

    return-void
.end method
