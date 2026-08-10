.class Lanet/channel/fulltrace/a$a;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Lanet/channel/fulltrace/IFullTraceAnalysis;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lanet/channel/fulltrace/a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "a"
.end annotation


# instance fields
.field private a:Lanet/channel/fulltrace/IFullTraceAnalysis;


# direct methods
.method constructor <init>(Lanet/channel/fulltrace/IFullTraceAnalysis;)V
    .locals 0

    .line 26
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lanet/channel/fulltrace/a$a;->a:Lanet/channel/fulltrace/IFullTraceAnalysis;

    const/4 p1, 0x1

    .line 28
    invoke-static {p1}, Lanet/channel/fulltrace/a;->a(Z)Z

    return-void
.end method


# virtual methods
.method public commitRequest(Ljava/lang/String;Lanet/channel/statist/RequestStatistic;)V
    .locals 3

    .line 52
    invoke-static {}, Lanet/channel/fulltrace/a;->b()Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lanet/channel/fulltrace/a$a;->a:Lanet/channel/fulltrace/IFullTraceAnalysis;

    if-eqz v0, :cond_1

    .line 57
    :try_start_0
    invoke-interface {v0, p1, p2}, Lanet/channel/fulltrace/IFullTraceAnalysis;->commitRequest(Ljava/lang/String;Lanet/channel/statist/RequestStatistic;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception p1

    const/4 p2, 0x0

    .line 59
    invoke-static {p2}, Lanet/channel/fulltrace/a;->a(Z)Z

    const/4 v0, 0x0

    new-array p2, p2, [Ljava/lang/Object;

    const-string v1, "anet.AnalysisFactory"

    const-string v2, "fulltrace commit fail."

    .line 60
    invoke-static {v1, v2, v0, p1, p2}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    :cond_1
    :goto_0
    return-void
.end method

.method public createRequest()Ljava/lang/String;
    .locals 5

    .line 33
    invoke-static {}, Lanet/channel/fulltrace/a;->b()Z

    move-result v0

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return-object v1

    :cond_0
    iget-object v0, p0, Lanet/channel/fulltrace/a$a;->a:Lanet/channel/fulltrace/IFullTraceAnalysis;

    if-eqz v0, :cond_1

    .line 40
    :try_start_0
    invoke-interface {v0}, Lanet/channel/fulltrace/IFullTraceAnalysis;->createRequest()Ljava/lang/String;

    move-result-object v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v0

    const/4 v2, 0x0

    .line 42
    invoke-static {v2}, Lanet/channel/fulltrace/a;->a(Z)Z

    const-string v3, "createRequest fail."

    new-array v2, v2, [Ljava/lang/Object;

    const-string v4, "anet.AnalysisFactory"

    .line 43
    invoke-static {v4, v3, v1, v0, v2}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    :cond_1
    :goto_0
    return-object v1
.end method

.method public getSceneInfo()Lanet/channel/fulltrace/b;
    .locals 5

    .line 67
    invoke-static {}, Lanet/channel/fulltrace/a;->b()Z

    move-result v0

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return-object v1

    :cond_0
    iget-object v0, p0, Lanet/channel/fulltrace/a$a;->a:Lanet/channel/fulltrace/IFullTraceAnalysis;

    if-eqz v0, :cond_1

    .line 73
    :try_start_0
    invoke-interface {v0}, Lanet/channel/fulltrace/IFullTraceAnalysis;->getSceneInfo()Lanet/channel/fulltrace/b;

    move-result-object v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v0

    const/4 v2, 0x0

    .line 75
    invoke-static {v2}, Lanet/channel/fulltrace/a;->a(Z)Z

    const-string v3, "getSceneInfo fail"

    new-array v2, v2, [Ljava/lang/Object;

    const-string v4, "anet.AnalysisFactory"

    .line 76
    invoke-static {v4, v3, v1, v0, v2}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    :cond_1
    :goto_0
    return-object v1
.end method
