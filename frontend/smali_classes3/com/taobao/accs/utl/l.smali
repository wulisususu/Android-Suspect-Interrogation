.class public Lcom/taobao/accs/utl/l;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Lanet/channel/util/ALog$ILog;


# instance fields
.field private a:Lcom/alibaba/sdk/android/logger/ILog;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 7
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, "NetworkSdk"

    .line 9
    invoke-static {v0}, Lcom/taobao/accs/utl/AccsLogger;->getLogger(Ljava/lang/Object;)Lcom/alibaba/sdk/android/logger/ILog;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/accs/utl/l;->a:Lcom/alibaba/sdk/android/logger/ILog;

    return-void
.end method

.method private a(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    .line 57
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "["

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, "]"

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method


# virtual methods
.method public d(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/accs/utl/l;->a:Lcom/alibaba/sdk/android/logger/ILog;

    .line 13
    invoke-direct {p0, p1, p2}, Lcom/taobao/accs/utl/l;->a(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-interface {v0, p1}, Lcom/alibaba/sdk/android/logger/ILog;->d(Ljava/lang/String;)V

    return-void
.end method

.method public e(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/accs/utl/l;->a:Lcom/alibaba/sdk/android/logger/ILog;

    .line 33
    invoke-direct {p0, p1, p2}, Lcom/taobao/accs/utl/l;->a(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-interface {v0, p1}, Lcom/alibaba/sdk/android/logger/ILog;->e(Ljava/lang/String;)V

    return-void
.end method

.method public e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/accs/utl/l;->a:Lcom/alibaba/sdk/android/logger/ILog;

    .line 38
    invoke-direct {p0, p1, p2}, Lcom/taobao/accs/utl/l;->a(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-interface {v0, p1, p3}, Lcom/alibaba/sdk/android/logger/ILog;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    return-void
.end method

.method public i(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/accs/utl/l;->a:Lcom/alibaba/sdk/android/logger/ILog;

    .line 18
    invoke-direct {p0, p1, p2}, Lcom/taobao/accs/utl/l;->a(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-interface {v0, p1}, Lcom/alibaba/sdk/android/logger/ILog;->i(Ljava/lang/String;)V

    return-void
.end method

.method public isPrintLog(I)Z
    .locals 0

    const/4 p1, 0x1

    return p1
.end method

.method public isValid()Z
    .locals 1

    const/4 v0, 0x1

    return v0
.end method

.method public setLogLevel(I)V
    .locals 0

    return-void
.end method

.method public w(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/accs/utl/l;->a:Lcom/alibaba/sdk/android/logger/ILog;

    .line 23
    invoke-direct {p0, p1, p2}, Lcom/taobao/accs/utl/l;->a(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-interface {v0, p1}, Lcom/alibaba/sdk/android/logger/ILog;->w(Ljava/lang/String;)V

    return-void
.end method

.method public w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/accs/utl/l;->a:Lcom/alibaba/sdk/android/logger/ILog;

    .line 28
    invoke-direct {p0, p1, p2}, Lcom/taobao/accs/utl/l;->a(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-interface {v0, p1, p3}, Lcom/alibaba/sdk/android/logger/ILog;->w(Ljava/lang/String;Ljava/lang/Throwable;)V

    return-void
.end method
