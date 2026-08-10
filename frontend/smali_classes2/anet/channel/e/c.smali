.class final Lanet/channel/e/c;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Lanet/channel/strategy/IStrategyListener;


# direct methods
.method constructor <init>()V
    .locals 0

    .line 74
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onStrategyUpdated(Lanet/channel/strategy/l$d;)V
    .locals 7

    if-eqz p1, :cond_6

    .line 77
    iget-object v0, p1, Lanet/channel/strategy/l$d;->b:[Lanet/channel/strategy/l$b;

    if-nez v0, :cond_0

    goto :goto_4

    :cond_0
    const/4 v0, 0x0

    move v1, v0

    .line 81
    :goto_0
    iget-object v2, p1, Lanet/channel/strategy/l$d;->b:[Lanet/channel/strategy/l$b;

    array-length v2, v2

    if-ge v1, v2, :cond_6

    .line 82
    iget-object v2, p1, Lanet/channel/strategy/l$d;->b:[Lanet/channel/strategy/l$b;

    aget-object v2, v2, v1

    iget-object v2, v2, Lanet/channel/strategy/l$b;->a:Ljava/lang/String;

    .line 83
    iget-object v3, p1, Lanet/channel/strategy/l$d;->b:[Lanet/channel/strategy/l$b;

    aget-object v3, v3, v1

    iget-object v3, v3, Lanet/channel/strategy/l$b;->h:[Lanet/channel/strategy/l$a;

    if-eqz v3, :cond_5

    .line 84
    array-length v4, v3

    if-gtz v4, :cond_1

    goto :goto_3

    :cond_1
    move v4, v0

    .line 87
    :goto_1
    array-length v5, v3

    if-ge v4, v5, :cond_5

    .line 88
    aget-object v5, v3, v4

    iget-object v5, v5, Lanet/channel/strategy/l$a;->b:Ljava/lang/String;

    const-string v6, "http3"

    .line 89
    invoke-virtual {v6, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-nez v6, :cond_3

    const-string v6, "http3plain"

    invoke-virtual {v6, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_2

    goto :goto_2

    :cond_2
    add-int/lit8 v4, v4, 0x1

    goto :goto_1

    .line 90
    :cond_3
    :goto_2
    invoke-static {}, Lanet/channel/e/a;->c()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v2, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_4

    .line 91
    invoke-static {v2}, Lanet/channel/e/a;->a(Ljava/lang/String;)Ljava/lang/String;

    .line 92
    invoke-static {}, Lanet/channel/e/a;->d()Landroid/content/SharedPreferences;

    move-result-object p1

    invoke-interface {p1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    const-string v0, "http3_detector_host"

    .line 93
    invoke-static {}, Lanet/channel/e/a;->c()Ljava/lang/String;

    move-result-object v1

    invoke-interface {p1, v0, v1}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    .line 94
    invoke-interface {p1}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 96
    :cond_4
    invoke-static {}, Lanet/channel/status/NetworkStatusHelper;->getStatus()Lanet/channel/status/NetworkStatusHelper$NetworkStatus;

    move-result-object p1

    invoke-static {p1}, Lanet/channel/e/a;->a(Lanet/channel/status/NetworkStatusHelper$NetworkStatus;)V

    return-void

    :cond_5
    :goto_3
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_6
    :goto_4
    return-void
.end method
