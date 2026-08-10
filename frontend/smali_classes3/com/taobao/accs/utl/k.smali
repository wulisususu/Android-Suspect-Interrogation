.class public Lcom/taobao/accs/utl/k;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Lanet/channel/util/ALog$ILog;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/taobao/accs/utl/k$a;
    }
.end annotation


# instance fields
.field private final a:Lanet/channel/util/ALog$ILog;

.field private final b:Lcom/taobao/accs/utl/k$a;


# direct methods
.method public constructor <init>(Lanet/channel/util/ALog$ILog;Lcom/taobao/accs/utl/k$a;)V
    .locals 0

    .line 10
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/taobao/accs/utl/k;->a:Lanet/channel/util/ALog$ILog;

    iput-object p2, p0, Lcom/taobao/accs/utl/k;->b:Lcom/taobao/accs/utl/k$a;

    return-void
.end method


# virtual methods
.method public d(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/accs/utl/k;->a:Lanet/channel/util/ALog$ILog;

    .line 17
    invoke-interface {v0, p1, p2}, Lanet/channel/util/ALog$ILog;->d(Ljava/lang/String;Ljava/lang/String;)V

    iget-object p1, p0, Lcom/taobao/accs/utl/k;->b:Lcom/taobao/accs/utl/k$a;

    .line 18
    invoke-interface {p1, p2}, Lcom/taobao/accs/utl/k$a;->a(Ljava/lang/String;)V

    return-void
.end method

.method public e(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/accs/utl/k;->a:Lanet/channel/util/ALog$ILog;

    .line 42
    invoke-interface {v0, p1, p2}, Lanet/channel/util/ALog$ILog;->e(Ljava/lang/String;Ljava/lang/String;)V

    iget-object p1, p0, Lcom/taobao/accs/utl/k;->b:Lcom/taobao/accs/utl/k$a;

    .line 43
    invoke-interface {p1, p2}, Lcom/taobao/accs/utl/k$a;->a(Ljava/lang/String;)V

    return-void
.end method

.method public e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/accs/utl/k;->a:Lanet/channel/util/ALog$ILog;

    .line 48
    invoke-interface {v0, p1, p2, p3}, Lanet/channel/util/ALog$ILog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    iget-object p1, p0, Lcom/taobao/accs/utl/k;->b:Lcom/taobao/accs/utl/k$a;

    .line 49
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    const-string v0, " "

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p3}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-interface {p1, p2}, Lcom/taobao/accs/utl/k$a;->a(Ljava/lang/String;)V

    return-void
.end method

.method public i(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/accs/utl/k;->a:Lanet/channel/util/ALog$ILog;

    .line 23
    invoke-interface {v0, p1, p2}, Lanet/channel/util/ALog$ILog;->i(Ljava/lang/String;Ljava/lang/String;)V

    iget-object p1, p0, Lcom/taobao/accs/utl/k;->b:Lcom/taobao/accs/utl/k$a;

    .line 24
    invoke-interface {p1, p2}, Lcom/taobao/accs/utl/k$a;->a(Ljava/lang/String;)V

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

    iget-object v0, p0, Lcom/taobao/accs/utl/k;->a:Lanet/channel/util/ALog$ILog;

    .line 30
    invoke-interface {v0, p1, p2}, Lanet/channel/util/ALog$ILog;->w(Ljava/lang/String;Ljava/lang/String;)V

    iget-object p1, p0, Lcom/taobao/accs/utl/k;->b:Lcom/taobao/accs/utl/k$a;

    .line 31
    invoke-interface {p1, p2}, Lcom/taobao/accs/utl/k$a;->a(Ljava/lang/String;)V

    return-void
.end method

.method public w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/accs/utl/k;->a:Lanet/channel/util/ALog$ILog;

    .line 36
    invoke-interface {v0, p1, p2, p3}, Lanet/channel/util/ALog$ILog;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)V

    iget-object p1, p0, Lcom/taobao/accs/utl/k;->b:Lcom/taobao/accs/utl/k$a;

    .line 37
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    const-string v0, " "

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p3}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-interface {p1, p2}, Lcom/taobao/accs/utl/k$a;->a(Ljava/lang/String;)V

    return-void
.end method
