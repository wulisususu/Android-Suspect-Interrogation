.class final Lcom/taobao/accs/utl/a;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Lcom/alibaba/sdk/android/logger/ILogger;


# instance fields
.field final synthetic a:Lanet/channel/util/ALog$ILog;


# direct methods
.method constructor <init>(Lanet/channel/util/ALog$ILog;)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/accs/utl/a;->a:Lanet/channel/util/ALog$ILog;

    .line 26
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public print(Lcom/alibaba/sdk/android/logger/LogLevel;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    .line 30
    :try_start_0
    sget-object v0, Lcom/taobao/accs/utl/b;->a:[I

    invoke-virtual {p1}, Lcom/alibaba/sdk/android/logger/LogLevel;->ordinal()I

    move-result p1

    aget p1, v0, p1

    const/4 v0, 0x1

    if-eq p1, v0, :cond_3

    const/4 v0, 0x2

    if-eq p1, v0, :cond_2

    const/4 v0, 0x3

    if-eq p1, v0, :cond_1

    const/4 v0, 0x4

    if-eq p1, v0, :cond_0

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lcom/taobao/accs/utl/a;->a:Lanet/channel/util/ALog$ILog;

    .line 41
    invoke-interface {p1, p2, p3}, Lanet/channel/util/ALog$ILog;->e(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    :cond_1
    iget-object p1, p0, Lcom/taobao/accs/utl/a;->a:Lanet/channel/util/ALog$ILog;

    .line 38
    invoke-interface {p1, p2, p3}, Lanet/channel/util/ALog$ILog;->w(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    :cond_2
    iget-object p1, p0, Lcom/taobao/accs/utl/a;->a:Lanet/channel/util/ALog$ILog;

    .line 35
    invoke-interface {p1, p2, p3}, Lanet/channel/util/ALog$ILog;->i(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    :cond_3
    iget-object p1, p0, Lcom/taobao/accs/utl/a;->a:Lanet/channel/util/ALog$ILog;

    .line 32
    invoke-interface {p1, p2, p3}, Lanet/channel/util/ALog$ILog;->d(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :catchall_0
    :goto_0
    return-void
.end method
