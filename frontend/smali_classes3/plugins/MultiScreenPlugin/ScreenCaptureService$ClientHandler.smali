.class Lplugins/MultiScreenPlugin/ScreenCaptureService$ClientHandler;
.super Ljava/lang/Object;
.source "ScreenCaptureService.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lplugins/MultiScreenPlugin/ScreenCaptureService;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "ClientHandler"
.end annotation


# instance fields
.field private connected:Ljava/util/concurrent/atomic/AtomicBoolean;

.field private outputStream:Ljava/io/OutputStream;

.field private socket:Ljava/net/Socket;

.field final synthetic this$0:Lplugins/MultiScreenPlugin/ScreenCaptureService;


# direct methods
.method public constructor <init>(Lplugins/MultiScreenPlugin/ScreenCaptureService;Ljava/net/Socket;)V
    .locals 1

    iput-object p1, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService$ClientHandler;->this$0:Lplugins/MultiScreenPlugin/ScreenCaptureService;

    .line 276
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 274
    new-instance p1, Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v0, 0x1

    invoke-direct {p1, v0}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    iput-object p1, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService$ClientHandler;->connected:Ljava/util/concurrent/atomic/AtomicBoolean;

    iput-object p2, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService$ClientHandler;->socket:Ljava/net/Socket;

    .line 279
    :try_start_0
    invoke-virtual {p2}, Ljava/net/Socket;->getOutputStream()Ljava/io/OutputStream;

    move-result-object p1

    iput-object p1, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService$ClientHandler;->outputStream:Ljava/io/OutputStream;
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    const-string p2, "ScreenCaptureService"

    const-string v0, "\u83b7\u53d6\u5ba2\u6237\u7aef\u8f93\u51fa\u6d41\u5931\u8d25"

    .line 281
    invoke-static {p2, v0, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    iget-object p1, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService$ClientHandler;->connected:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 p2, 0x0

    .line 282
    invoke-virtual {p1, p2}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    :goto_0
    return-void
.end method


# virtual methods
.method public close()V
    .locals 3

    iget-object v0, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService$ClientHandler;->connected:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    .line 341
    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    :try_start_0
    iget-object v0, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService$ClientHandler;->outputStream:Ljava/io/OutputStream;

    if-eqz v0, :cond_0

    .line 344
    invoke-virtual {v0}, Ljava/io/OutputStream;->close()V

    :cond_0
    iget-object v0, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService$ClientHandler;->socket:Ljava/net/Socket;

    if-eqz v0, :cond_1

    .line 346
    invoke-virtual {v0}, Ljava/net/Socket;->isClosed()Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService$ClientHandler;->socket:Ljava/net/Socket;

    .line 347
    invoke-virtual {v0}, Ljava/net/Socket;->close()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    const-string v1, "ScreenCaptureService"

    const-string v2, "\u5173\u95ed\u5ba2\u6237\u7aef\u8fde\u63a5\u5931\u8d25"

    .line 350
    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :cond_1
    :goto_0
    return-void
.end method

.method public run()V
    .locals 3

    :try_start_0
    const-string v0, "HTTP/1.1 200 OK\r\nContent-Type: multipart/x-mixed-replace; boundary=mjpegstream\r\nCache-Control: no-cache\r\nConnection: close\r\n\r\n"

    iget-object v1, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService$ClientHandler;->outputStream:Ljava/io/OutputStream;

    .line 295
    invoke-virtual {v0}, Ljava/lang/String;->getBytes()[B

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/io/OutputStream;->write([B)V

    iget-object v0, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService$ClientHandler;->outputStream:Ljava/io/OutputStream;

    .line 296
    invoke-virtual {v0}, Ljava/io/OutputStream;->flush()V

    :goto_0
    iget-object v0, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService$ClientHandler;->connected:Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 299
    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService$ClientHandler;->socket:Ljava/net/Socket;

    invoke-virtual {v0}, Ljava/net/Socket;->isClosed()Z

    move-result v0

    if-nez v0, :cond_0

    const-wide/16 v0, 0x64

    .line 300
    invoke-static {v0, v1}, Ljava/lang/Thread;->sleep(J)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v0

    goto :goto_1

    :catch_0
    move-exception v0

    :try_start_1
    const-string v1, "ScreenCaptureService"

    const-string v2, "\u5ba2\u6237\u7aef\u8fde\u63a5\u5f02\u5e38"

    .line 303
    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 305
    :cond_0
    invoke-virtual {p0}, Lplugins/MultiScreenPlugin/ScreenCaptureService$ClientHandler;->close()V

    return-void

    :goto_1
    invoke-virtual {p0}, Lplugins/MultiScreenPlugin/ScreenCaptureService$ClientHandler;->close()V

    .line 306
    throw v0
.end method

.method public sendFrame([B)Z
    .locals 3

    const-string v0, "--mjpegstream\r\nContent-Type: image/jpeg\r\nContent-Length: "

    iget-object v1, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService$ClientHandler;->connected:Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 313
    invoke-virtual {v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v1

    const/4 v2, 0x0

    if-eqz v1, :cond_1

    iget-object v1, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService$ClientHandler;->socket:Ljava/net/Socket;

    invoke-virtual {v1}, Ljava/net/Socket;->isClosed()Z

    move-result v1

    if-eqz v1, :cond_0

    goto :goto_0

    .line 319
    :cond_0
    :try_start_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    array-length v0, p1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\r\n\r\n"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService$ClientHandler;->outputStream:Ljava/io/OutputStream;

    .line 324
    invoke-virtual {v0}, Ljava/lang/String;->getBytes()[B

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/io/OutputStream;->write([B)V

    iget-object v0, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService$ClientHandler;->outputStream:Ljava/io/OutputStream;

    .line 325
    invoke-virtual {v0, p1}, Ljava/io/OutputStream;->write([B)V

    iget-object p1, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService$ClientHandler;->outputStream:Ljava/io/OutputStream;

    const-string v0, "\r\n"

    .line 326
    invoke-virtual {v0}, Ljava/lang/String;->getBytes()[B

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/io/OutputStream;->write([B)V

    iget-object p1, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService$ClientHandler;->outputStream:Ljava/io/OutputStream;

    .line 327
    invoke-virtual {p1}, Ljava/io/OutputStream;->flush()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    const/4 p1, 0x1

    return p1

    :catch_0
    move-exception p1

    const-string v0, "ScreenCaptureService"

    const-string v1, "\u53d1\u9001\u5e27\u6570\u636e\u5931\u8d25"

    .line 331
    invoke-static {v0, v1, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    iget-object p1, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService$ClientHandler;->connected:Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 332
    invoke-virtual {p1, v2}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    :cond_1
    :goto_0
    return v2
.end method
