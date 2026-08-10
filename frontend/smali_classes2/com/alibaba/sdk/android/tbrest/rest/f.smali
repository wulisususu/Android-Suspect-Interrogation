.class public Lcom/alibaba/sdk/android/tbrest/rest/f;
.super Ljava/lang/Object;
.source "RestSecuritySDKRequestAuthentication.java"


# instance fields
.field private a:Ljava/lang/Class;

.field private a:Ljava/lang/Object;

.field private a:Ljava/lang/reflect/Field;

.field private a:Ljava/lang/reflect/Method;

.field private b:Ljava/lang/Object;

.field private b:Ljava/lang/String;

.field private b:Ljava/lang/reflect/Field;

.field private c:Ljava/lang/reflect/Field;

.field private e:Z

.field private h:I

.field private mContext:Landroid/content/Context;


# direct methods
.method public constructor <init>(Landroid/content/Context;Ljava/lang/String;)V
    .locals 1

    .line 30
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/alibaba/sdk/android/tbrest/rest/f;->a:Ljava/lang/Object;

    iput-object v0, p0, Lcom/alibaba/sdk/android/tbrest/rest/f;->b:Ljava/lang/Object;

    iput-object v0, p0, Lcom/alibaba/sdk/android/tbrest/rest/f;->a:Ljava/lang/Class;

    iput-object v0, p0, Lcom/alibaba/sdk/android/tbrest/rest/f;->a:Ljava/lang/reflect/Field;

    iput-object v0, p0, Lcom/alibaba/sdk/android/tbrest/rest/f;->b:Ljava/lang/reflect/Field;

    iput-object v0, p0, Lcom/alibaba/sdk/android/tbrest/rest/f;->c:Ljava/lang/reflect/Field;

    iput-object v0, p0, Lcom/alibaba/sdk/android/tbrest/rest/f;->a:Ljava/lang/reflect/Method;

    const/4 v0, 0x1

    iput v0, p0, Lcom/alibaba/sdk/android/tbrest/rest/f;->h:I

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/alibaba/sdk/android/tbrest/rest/f;->e:Z

    iput-object p1, p0, Lcom/alibaba/sdk/android/tbrest/rest/f;->mContext:Landroid/content/Context;

    iput-object p2, p0, Lcom/alibaba/sdk/android/tbrest/rest/f;->b:Ljava/lang/String;

    return-void
.end method

.method private declared-synchronized g()V
    .locals 7

    monitor-enter p0

    :try_start_0
    iget-boolean v0, p0, Lcom/alibaba/sdk/android/tbrest/rest/f;->e:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_5

    if-eqz v0, :cond_0

    .line 48
    monitor-exit p0

    return-void

    :cond_0
    const/4 v0, 0x0

    const/4 v1, 0x1

    const/4 v2, 0x0

    :try_start_1
    const-string v3, "com.taobao.wireless.security.sdk.SecurityGuardManager"

    .line 52
    invoke-static {v3}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v3
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    const-string v4, "getInstance"

    new-array v5, v1, [Ljava/lang/Class;

    .line 53
    const-class v6, Landroid/content/Context;

    aput-object v6, v5, v2

    invoke-virtual {v3, v4, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v4

    new-array v5, v1, [Ljava/lang/Object;

    iget-object v6, p0, Lcom/alibaba/sdk/android/tbrest/rest/f;->mContext:Landroid/content/Context;

    aput-object v6, v5, v2

    .line 54
    invoke-virtual {v4, v0, v5}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    iput-object v4, p0, Lcom/alibaba/sdk/android/tbrest/rest/f;->a:Ljava/lang/Object;

    const-string v4, "getSecureSignatureComp"

    new-array v5, v2, [Ljava/lang/Class;

    .line 56
    invoke-virtual {v3, v4, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v4

    iget-object v5, p0, Lcom/alibaba/sdk/android/tbrest/rest/f;->a:Ljava/lang/Object;

    new-array v6, v2, [Ljava/lang/Object;

    .line 57
    invoke-virtual {v4, v5, v6}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    iput-object v4, p0, Lcom/alibaba/sdk/android/tbrest/rest/f;->b:Ljava/lang/Object;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    goto :goto_0

    :catchall_0
    move-object v3, v0

    :catchall_1
    :try_start_3
    const-string v4, "initSecurityCheck failure, It\'s ok "

    .line 59
    invoke-static {v4}, Lcom/alibaba/sdk/android/tbrest/utils/LogUtil;->i(Ljava/lang/String;)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_5

    :goto_0
    if-eqz v3, :cond_3

    :try_start_4
    const-string v4, "com.taobao.wireless.security.sdk.SecurityGuardParamContext"

    .line 63
    invoke-static {v4}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v4

    iput-object v4, p0, Lcom/alibaba/sdk/android/tbrest/rest/f;->a:Ljava/lang/Class;

    const-string v5, "appKey"

    .line 66
    invoke-virtual {v4, v5}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v4

    iput-object v4, p0, Lcom/alibaba/sdk/android/tbrest/rest/f;->a:Ljava/lang/reflect/Field;

    iget-object v4, p0, Lcom/alibaba/sdk/android/tbrest/rest/f;->a:Ljava/lang/Class;

    const-string v5, "paramMap"

    .line 68
    invoke-virtual {v4, v5}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v4

    iput-object v4, p0, Lcom/alibaba/sdk/android/tbrest/rest/f;->b:Ljava/lang/reflect/Field;

    iget-object v4, p0, Lcom/alibaba/sdk/android/tbrest/rest/f;->a:Ljava/lang/Class;

    const-string v5, "requestType"

    .line 70
    invoke-virtual {v4, v5}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v4

    iput-object v4, p0, Lcom/alibaba/sdk/android/tbrest/rest/f;->c:Ljava/lang/reflect/Field;
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_4

    :try_start_5
    const-string v4, "isOpen"

    new-array v5, v2, [Ljava/lang/Class;

    .line 75
    invoke-virtual {v3, v4, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v3
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_2

    goto :goto_1

    :catchall_2
    :try_start_6
    const-string v3, "initSecurityCheck failure, It\'s ok"

    .line 77
    invoke-static {v3}, Lcom/alibaba/sdk/android/tbrest/utils/LogUtil;->i(Ljava/lang/String;)V

    move-object v3, v0

    :goto_1
    if-eqz v3, :cond_1

    iget-object v0, p0, Lcom/alibaba/sdk/android/tbrest/rest/f;->a:Ljava/lang/Object;

    new-array v4, v2, [Ljava/lang/Object;

    .line 81
    invoke-virtual {v3, v0, v4}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Boolean;

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_4

    if-eqz v0, :cond_2

    goto :goto_3

    :cond_1
    :try_start_7
    const-string v3, "com.taobao.wireless.security.sdk.securitybody.ISecurityBodyComponent"

    .line 86
    invoke-static {v3}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_3

    goto :goto_2

    :catchall_3
    :try_start_8
    const-string v3, "initSecurityCheck failure, It\'s ok"

    .line 90
    invoke-static {v3}, Lcom/alibaba/sdk/android/tbrest/utils/LogUtil;->i(Ljava/lang/String;)V

    :goto_2
    if-nez v0, :cond_2

    :goto_3
    move v0, v1

    goto :goto_4

    :cond_2
    const/16 v0, 0xc

    :goto_4
    iput v0, p0, Lcom/alibaba/sdk/android/tbrest/rest/f;->h:I

    const-string v0, "com.taobao.wireless.security.sdk.securesignature.ISecureSignatureComponent"

    .line 99
    invoke-static {v0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    const-string v3, "signRequest"

    new-array v4, v1, [Ljava/lang/Class;

    iget-object v5, p0, Lcom/alibaba/sdk/android/tbrest/rest/f;->a:Ljava/lang/Class;

    aput-object v5, v4, v2

    .line 101
    invoke-virtual {v0, v3, v4}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    iput-object v0, p0, Lcom/alibaba/sdk/android/tbrest/rest/f;->a:Ljava/lang/reflect/Method;
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_4

    goto :goto_5

    :catchall_4
    :try_start_9
    const-string v0, "initSecurityCheck failure, It\'s ok"

    .line 105
    invoke-static {v0}, Lcom/alibaba/sdk/android/tbrest/utils/LogUtil;->i(Ljava/lang/String;)V

    :cond_3
    :goto_5
    iput-boolean v1, p0, Lcom/alibaba/sdk/android/tbrest/rest/f;->e:Z
    :try_end_9
    .catchall {:try_start_9 .. :try_end_9} :catchall_5

    .line 108
    monitor-exit p0

    return-void

    :catchall_5
    move-exception v0

    monitor-exit p0

    throw v0
.end method


# virtual methods
.method public b(Ljava/lang/String;)Ljava/lang/String;
    .locals 4

    iget-boolean v0, p0, Lcom/alibaba/sdk/android/tbrest/rest/f;->e:Z

    if-nez v0, :cond_0

    .line 120
    invoke-direct {p0}, Lcom/alibaba/sdk/android/tbrest/rest/f;->g()V

    :cond_0
    iget-object v0, p0, Lcom/alibaba/sdk/android/tbrest/rest/f;->b:Ljava/lang/String;

    const/4 v1, 0x0

    if-nez v0, :cond_1

    const-string p1, "RestSecuritySDKRequestAuthentication:getSign There is no appkey,please check it!"

    .line 124
    invoke-static {p1}, Lcom/alibaba/sdk/android/tbrest/utils/LogUtil;->e(Ljava/lang/String;)V

    return-object v1

    :cond_1
    if-nez p1, :cond_2

    return-object v1

    :cond_2
    iget-object v0, p0, Lcom/alibaba/sdk/android/tbrest/rest/f;->a:Ljava/lang/Object;

    if-eqz v0, :cond_3

    iget-object v0, p0, Lcom/alibaba/sdk/android/tbrest/rest/f;->a:Ljava/lang/Class;

    if-eqz v0, :cond_3

    iget-object v2, p0, Lcom/alibaba/sdk/android/tbrest/rest/f;->a:Ljava/lang/reflect/Field;

    if-eqz v2, :cond_3

    iget-object v2, p0, Lcom/alibaba/sdk/android/tbrest/rest/f;->b:Ljava/lang/reflect/Field;

    if-eqz v2, :cond_3

    iget-object v2, p0, Lcom/alibaba/sdk/android/tbrest/rest/f;->c:Ljava/lang/reflect/Field;

    if-eqz v2, :cond_3

    iget-object v2, p0, Lcom/alibaba/sdk/android/tbrest/rest/f;->a:Ljava/lang/reflect/Method;

    if-eqz v2, :cond_3

    iget-object v2, p0, Lcom/alibaba/sdk/android/tbrest/rest/f;->b:Ljava/lang/Object;

    if-eqz v2, :cond_3

    .line 143
    :try_start_0
    invoke-virtual {v0}, Ljava/lang/Class;->newInstance()Ljava/lang/Object;

    move-result-object v0

    iget-object v2, p0, Lcom/alibaba/sdk/android/tbrest/rest/f;->a:Ljava/lang/reflect/Field;

    iget-object v3, p0, Lcom/alibaba/sdk/android/tbrest/rest/f;->b:Ljava/lang/String;

    .line 144
    invoke-virtual {v2, v0, v3}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V

    iget-object v2, p0, Lcom/alibaba/sdk/android/tbrest/rest/f;->b:Ljava/lang/reflect/Field;

    .line 145
    invoke-virtual {v2, v0}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/util/Map;

    const-string v3, "INPUT"

    .line 147
    invoke-interface {v2, v3, p1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p1, p0, Lcom/alibaba/sdk/android/tbrest/rest/f;->c:Ljava/lang/reflect/Field;

    iget v2, p0, Lcom/alibaba/sdk/android/tbrest/rest/f;->h:I

    .line 150
    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    .line 149
    invoke-virtual {p1, v0, v2}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V

    iget-object p1, p0, Lcom/alibaba/sdk/android/tbrest/rest/f;->a:Ljava/lang/reflect/Method;

    iget-object v2, p0, Lcom/alibaba/sdk/android/tbrest/rest/f;->b:Ljava/lang/Object;

    .line 152
    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    invoke-virtual {p1, v2, v0}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/InstantiationException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/reflect/InvocationTargetException; {:try_start_0 .. :try_end_0} :catch_0

    move-object v1, p1

    goto :goto_0

    :catch_0
    move-exception p1

    .line 162
    invoke-virtual {p1}, Ljava/lang/reflect/InvocationTargetException;->printStackTrace()V

    goto :goto_0

    :catch_1
    move-exception p1

    .line 160
    invoke-virtual {p1}, Ljava/lang/IllegalArgumentException;->printStackTrace()V

    goto :goto_0

    :catch_2
    move-exception p1

    .line 158
    invoke-virtual {p1}, Ljava/lang/IllegalAccessException;->printStackTrace()V

    goto :goto_0

    :catch_3
    move-exception p1

    .line 156
    invoke-virtual {p1}, Ljava/lang/InstantiationException;->printStackTrace()V

    :cond_3
    :goto_0
    return-object v1
.end method
