.class public Lanet/channel/Config$Builder;
.super Ljava/lang/Object;
.source "Taobao"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lanet/channel/Config;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "Builder"
.end annotation


# instance fields
.field private a:Ljava/lang/String;

.field private b:Ljava/lang/String;

.field private c:Lanet/channel/entity/ENV;

.field private d:Ljava/lang/String;

.field private e:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 73
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 76
    sget-object v0, Lanet/channel/entity/ENV;->ONLINE:Lanet/channel/entity/ENV;

    iput-object v0, p0, Lanet/channel/Config$Builder;->c:Lanet/channel/entity/ENV;

    return-void
.end method


# virtual methods
.method public build()Lanet/channel/Config;
    .locals 7

    iget-object v0, p0, Lanet/channel/Config$Builder;->b:Ljava/lang/String;

    .line 106
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_5

    .line 110
    invoke-static {}, Lanet/channel/Config;->a()Ljava/util/Map;

    move-result-object v0

    monitor-enter v0

    .line 111
    :try_start_0
    invoke-static {}, Lanet/channel/Config;->a()Ljava/util/Map;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_2

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lanet/channel/Config;

    .line 112
    invoke-static {v2}, Lanet/channel/Config;->a(Lanet/channel/Config;)Lanet/channel/entity/ENV;

    move-result-object v3

    iget-object v4, p0, Lanet/channel/Config$Builder;->c:Lanet/channel/entity/ENV;

    if-ne v3, v4, :cond_0

    invoke-static {v2}, Lanet/channel/Config;->b(Lanet/channel/Config;)Ljava/lang/String;

    move-result-object v3

    iget-object v4, p0, Lanet/channel/Config$Builder;->b:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    const-string v1, "awcn.Config"

    const-string v3, "duplicated config exist!"

    const/4 v4, 0x4

    new-array v4, v4, [Ljava/lang/Object;

    const-string v5, "appkey"

    const/4 v6, 0x0

    aput-object v5, v4, v6

    iget-object v5, p0, Lanet/channel/Config$Builder;->b:Ljava/lang/String;

    const/4 v6, 0x1

    aput-object v5, v4, v6

    const-string v5, "env"

    const/4 v6, 0x2

    aput-object v5, v4, v6

    iget-object v5, p0, Lanet/channel/Config$Builder;->c:Lanet/channel/entity/ENV;

    const/4 v6, 0x3

    aput-object v5, v4, v6

    const/4 v5, 0x0

    .line 113
    invoke-static {v1, v3, v5, v4}, Lanet/channel/util/ALog;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object v1, p0, Lanet/channel/Config$Builder;->a:Ljava/lang/String;

    .line 114
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_1

    .line 115
    invoke-static {}, Lanet/channel/Config;->a()Ljava/util/Map;

    move-result-object v1

    iget-object v3, p0, Lanet/channel/Config$Builder;->a:Ljava/lang/String;

    invoke-interface {v1, v3, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 117
    :cond_1
    monitor-exit v0

    return-object v2

    .line 120
    :cond_2
    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 122
    new-instance v0, Lanet/channel/Config;

    invoke-direct {v0}, Lanet/channel/Config;-><init>()V

    iget-object v1, p0, Lanet/channel/Config$Builder;->b:Ljava/lang/String;

    .line 123
    invoke-static {v0, v1}, Lanet/channel/Config;->a(Lanet/channel/Config;Ljava/lang/String;)Ljava/lang/String;

    iget-object v1, p0, Lanet/channel/Config$Builder;->c:Lanet/channel/entity/ENV;

    .line 124
    invoke-static {v0, v1}, Lanet/channel/Config;->a(Lanet/channel/Config;Lanet/channel/entity/ENV;)Lanet/channel/entity/ENV;

    iget-object v1, p0, Lanet/channel/Config$Builder;->a:Ljava/lang/String;

    .line 126
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_3

    iget-object v1, p0, Lanet/channel/Config$Builder;->b:Ljava/lang/String;

    const-string v2, "$"

    iget-object v3, p0, Lanet/channel/Config$Builder;->c:Lanet/channel/entity/ENV;

    .line 127
    invoke-virtual {v3}, Lanet/channel/entity/ENV;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v1, v2, v3}, Lanet/channel/util/StringUtils;->concatString(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lanet/channel/Config;->b(Lanet/channel/Config;Ljava/lang/String;)Ljava/lang/String;

    goto :goto_0

    :cond_3
    iget-object v1, p0, Lanet/channel/Config$Builder;->a:Ljava/lang/String;

    .line 129
    invoke-static {v0, v1}, Lanet/channel/Config;->b(Lanet/channel/Config;Ljava/lang/String;)Ljava/lang/String;

    :goto_0
    iget-object v1, p0, Lanet/channel/Config$Builder;->e:Ljava/lang/String;

    .line 132
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_4

    .line 133
    invoke-static {}, Lanet/channel/security/c;->a()Lanet/channel/security/ISecurityFactory;

    move-result-object v1

    iget-object v2, p0, Lanet/channel/Config$Builder;->e:Ljava/lang/String;

    invoke-interface {v1, v2}, Lanet/channel/security/ISecurityFactory;->createNonSecurity(Ljava/lang/String;)Lanet/channel/security/ISecurity;

    move-result-object v1

    invoke-static {v0, v1}, Lanet/channel/Config;->a(Lanet/channel/Config;Lanet/channel/security/ISecurity;)Lanet/channel/security/ISecurity;

    goto :goto_1

    .line 135
    :cond_4
    invoke-static {}, Lanet/channel/security/c;->a()Lanet/channel/security/ISecurityFactory;

    move-result-object v1

    iget-object v2, p0, Lanet/channel/Config$Builder;->d:Ljava/lang/String;

    invoke-interface {v1, v2}, Lanet/channel/security/ISecurityFactory;->createSecurity(Ljava/lang/String;)Lanet/channel/security/ISecurity;

    move-result-object v1

    invoke-static {v0, v1}, Lanet/channel/Config;->a(Lanet/channel/Config;Lanet/channel/security/ISecurity;)Lanet/channel/security/ISecurity;

    .line 138
    :goto_1
    invoke-static {}, Lanet/channel/Config;->a()Ljava/util/Map;

    move-result-object v1

    monitor-enter v1

    .line 139
    :try_start_1
    invoke-static {}, Lanet/channel/Config;->a()Ljava/util/Map;

    move-result-object v2

    invoke-static {v0}, Lanet/channel/Config;->c(Lanet/channel/Config;)Ljava/lang/String;

    move-result-object v3

    invoke-interface {v2, v3, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 140
    monitor-exit v1

    return-object v0

    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0

    :catchall_1
    move-exception v1

    .line 120
    :try_start_2
    monitor-exit v0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    throw v1

    .line 107
    :cond_5
    new-instance v0, Ljava/lang/RuntimeException;

    const-string v1, "appkey can not be null or empty!"

    invoke-direct {v0, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public setAppSecret(Ljava/lang/String;)Lanet/channel/Config$Builder;
    .locals 0

    iput-object p1, p0, Lanet/channel/Config$Builder;->e:Ljava/lang/String;

    return-object p0
.end method

.method public setAppkey(Ljava/lang/String;)Lanet/channel/Config$Builder;
    .locals 0

    iput-object p1, p0, Lanet/channel/Config$Builder;->b:Ljava/lang/String;

    return-object p0
.end method

.method public setAuthCode(Ljava/lang/String;)Lanet/channel/Config$Builder;
    .locals 0

    iput-object p1, p0, Lanet/channel/Config$Builder;->d:Ljava/lang/String;

    return-object p0
.end method

.method public setEnv(Lanet/channel/entity/ENV;)Lanet/channel/Config$Builder;
    .locals 0

    iput-object p1, p0, Lanet/channel/Config$Builder;->c:Lanet/channel/entity/ENV;

    return-object p0
.end method

.method public setTag(Ljava/lang/String;)Lanet/channel/Config$Builder;
    .locals 0

    iput-object p1, p0, Lanet/channel/Config$Builder;->a:Ljava/lang/String;

    return-object p0
.end method
