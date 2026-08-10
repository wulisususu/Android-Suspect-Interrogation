.class public Lanet/channel/SessionRequest$c;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lanet/channel/SessionRequest;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4
    name = "c"
.end annotation


# instance fields
.field a:Lanet/channel/SessionGetCallback;

.field b:Ljava/util/concurrent/atomic/AtomicBoolean;

.field final synthetic c:Lanet/channel/SessionRequest;


# direct methods
.method protected constructor <init>(Lanet/channel/SessionRequest;Lanet/channel/SessionGetCallback;)V
    .locals 1

    iput-object p1, p0, Lanet/channel/SessionRequest$c;->c:Lanet/channel/SessionRequest;

    .line 130
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 p1, 0x0

    iput-object p1, p0, Lanet/channel/SessionRequest$c;->a:Lanet/channel/SessionGetCallback;

    .line 128
    new-instance p1, Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v0, 0x0

    invoke-direct {p1, v0}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    iput-object p1, p0, Lanet/channel/SessionRequest$c;->b:Ljava/util/concurrent/atomic/AtomicBoolean;

    iput-object p2, p0, Lanet/channel/SessionRequest$c;->a:Lanet/channel/SessionGetCallback;

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    iget-object v0, p0, Lanet/channel/SessionRequest$c;->b:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x1

    const/4 v2, 0x0

    .line 136
    invoke-virtual {v0, v2, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->compareAndSet(ZZ)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "awcn.SessionRequest"

    const-string v1, "get session timeout"

    const/4 v3, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    .line 137
    invoke-static {v0, v1, v3, v2}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object v0, p0, Lanet/channel/SessionRequest$c;->c:Lanet/channel/SessionRequest;

    .line 1060
    iget-object v0, v0, Lanet/channel/SessionRequest;->g:Ljava/util/HashMap;

    .line 138
    monitor-enter v0

    :try_start_0
    iget-object v1, p0, Lanet/channel/SessionRequest$c;->c:Lanet/channel/SessionRequest;

    .line 2060
    iget-object v1, v1, Lanet/channel/SessionRequest;->g:Ljava/util/HashMap;

    iget-object v2, p0, Lanet/channel/SessionRequest$c;->a:Lanet/channel/SessionGetCallback;

    .line 139
    invoke-virtual {v1, v2}, Ljava/util/HashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 140
    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    iget-object v0, p0, Lanet/channel/SessionRequest$c;->a:Lanet/channel/SessionGetCallback;

    .line 141
    invoke-interface {v0}, Lanet/channel/SessionGetCallback;->onSessionGetFail()V

    goto :goto_0

    :catchall_0
    move-exception v1

    .line 140
    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v1

    :cond_0
    :goto_0
    return-void
.end method
