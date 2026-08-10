.class final Lcom/taobao/agoo/c;
.super Lcom/taobao/accs/IAgooAppReceiver;
.source "Taobao"


# instance fields
.field final synthetic a:Lcom/taobao/agoo/IRegister;

.field final synthetic b:Landroid/content/Context;

.field final synthetic c:Lcom/taobao/accs/IACCSManager;

.field final synthetic d:Ljava/lang/String;

.field final synthetic e:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/taobao/agoo/IRegister;Landroid/content/Context;Lcom/taobao/accs/IACCSManager;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/agoo/c;->a:Lcom/taobao/agoo/IRegister;

    iput-object p2, p0, Lcom/taobao/agoo/c;->b:Landroid/content/Context;

    iput-object p3, p0, Lcom/taobao/agoo/c;->c:Lcom/taobao/accs/IACCSManager;

    iput-object p4, p0, Lcom/taobao/agoo/c;->d:Ljava/lang/String;

    iput-object p5, p0, Lcom/taobao/agoo/c;->e:Ljava/lang/String;

    .line 140
    invoke-direct {p0}, Lcom/taobao/accs/IAgooAppReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public getAppkey()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/taobao/agoo/c;->d:Ljava/lang/String;

    return-object v0
.end method

.method public onBindApp(ILjava/lang/String;)V
    .locals 6

    const-string p2, "AgooDeviceCmd"

    const-string v0, "TaobaoRegister"

    const/4 v1, 0x0

    :try_start_0
    const-string v2, "onBindApp"

    const/4 v3, 0x2

    new-array v3, v3, [Ljava/lang/Object;

    const-string v4, "errorCode"

    aput-object v4, v3, v1

    .line 158
    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    const/4 v5, 0x1

    aput-object v4, v3, v5

    invoke-static {v0, v2, v3}, Lcom/taobao/accs/utl/ALog;->i(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 159
    sget-object v2, Lcom/taobao/accs/AccsErrorCode;->SUCCESS:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {v2}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v2

    if-ne p1, v2, :cond_6

    .line 160
    invoke-static {}, Lcom/taobao/agoo/TaobaoRegister;->access$000()Lcom/taobao/agoo/a/b;

    move-result-object p1

    if-nez p1, :cond_0

    .line 161
    new-instance p1, Lcom/taobao/agoo/a/b;

    iget-object v2, p0, Lcom/taobao/agoo/c;->b:Landroid/content/Context;

    invoke-direct {p1, v2}, Lcom/taobao/agoo/a/b;-><init>(Landroid/content/Context;)V

    invoke-static {p1}, Lcom/taobao/agoo/TaobaoRegister;->access$002(Lcom/taobao/agoo/a/b;)Lcom/taobao/agoo/a/b;

    :cond_0
    iget-object p1, p0, Lcom/taobao/agoo/c;->c:Lcom/taobao/accs/IACCSManager;

    iget-object v2, p0, Lcom/taobao/agoo/c;->b:Landroid/content/Context;

    .line 164
    invoke-static {}, Lcom/taobao/agoo/TaobaoRegister;->access$000()Lcom/taobao/agoo/a/b;

    move-result-object v3

    .line 163
    invoke-interface {p1, v2, p2, v3}, Lcom/taobao/accs/IACCSManager;->registerDataListener(Landroid/content/Context;Ljava/lang/String;Lcom/taobao/accs/base/AccsAbstractDataListener;)V

    .line 165
    sget-object p1, Lcom/taobao/agoo/a/b;->b:Lcom/taobao/agoo/a/a;

    iget-object v2, p0, Lcom/taobao/agoo/c;->b:Landroid/content/Context;

    .line 166
    invoke-virtual {v2}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v2

    .line 165
    invoke-virtual {p1, v2}, Lcom/taobao/agoo/a/a;->b(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_2

    iget-object p1, p0, Lcom/taobao/agoo/c;->b:Landroid/content/Context;

    .line 167
    invoke-static {p1}, Lorg/android/agoo/common/Config;->getDeviceToken(Landroid/content/Context;)Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_2

    const-string p1, "agoo aready Registered return "

    new-array p2, v1, [Ljava/lang/Object;

    .line 168
    invoke-static {v0, p1, p2}, Lcom/taobao/accs/utl/ALog;->i(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    iget-object p1, p0, Lcom/taobao/agoo/c;->a:Lcom/taobao/agoo/IRegister;

    if-eqz p1, :cond_1

    iget-object p2, p0, Lcom/taobao/agoo/c;->b:Landroid/content/Context;

    .line 170
    invoke-static {p2}, Lorg/android/agoo/common/Config;->getDeviceToken(Landroid/content/Context;)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Lcom/taobao/agoo/IRegister;->onSuccess(Ljava/lang/String;)V

    :cond_1
    return-void

    :cond_2
    iget-object p1, p0, Lcom/taobao/agoo/c;->b:Landroid/content/Context;

    iget-object v2, p0, Lcom/taobao/agoo/c;->d:Ljava/lang/String;

    iget-object v3, p0, Lcom/taobao/agoo/c;->e:Ljava/lang/String;

    .line 175
    invoke-static {p1, v2, v3}, Lcom/taobao/agoo/a/a/c;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)[B

    move-result-object p1

    if-nez p1, :cond_4

    iget-object p1, p0, Lcom/taobao/agoo/c;->a:Lcom/taobao/agoo/IRegister;

    if-eqz p1, :cond_3

    .line 178
    sget-object p2, Lcom/taobao/agoo/a;->REGISTER_DATA_ERROR:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCode()Ljava/lang/String;

    move-result-object p2

    sget-object v2, Lcom/taobao/agoo/a;->REGISTER_DATA_ERROR:Lcom/alibaba/sdk/android/error/ErrorCode;

    .line 179
    invoke-virtual {v2}, Lcom/alibaba/sdk/android/error/ErrorCode;->getMsg()Ljava/lang/String;

    move-result-object v2

    .line 178
    invoke-virtual {p1, p2, v2}, Lcom/taobao/agoo/IRegister;->onFailure(Ljava/lang/String;Ljava/lang/String;)V

    :cond_3
    return-void

    .line 183
    :cond_4
    new-instance v2, Lcom/taobao/accs/ACCSManager$AccsRequest;

    const/4 v3, 0x0

    invoke-direct {v2, v3, p2, p1, v3}, Lcom/taobao/accs/ACCSManager$AccsRequest;-><init>(Ljava/lang/String;Ljava/lang/String;[BLjava/lang/String;)V

    iget-object p1, p0, Lcom/taobao/agoo/c;->c:Lcom/taobao/accs/IACCSManager;

    iget-object p2, p0, Lcom/taobao/agoo/c;->b:Landroid/content/Context;

    .line 185
    invoke-interface {p1, p2, v2}, Lcom/taobao/accs/IACCSManager;->sendRequest(Landroid/content/Context;Lcom/taobao/accs/ACCSManager$AccsRequest;)Ljava/lang/String;

    move-result-object p1

    .line 186
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result p2

    if-eqz p2, :cond_5

    iget-object p1, p0, Lcom/taobao/agoo/c;->a:Lcom/taobao/agoo/IRegister;

    if-eqz p1, :cond_7

    .line 188
    sget-object p2, Lcom/taobao/agoo/a;->ACCS_CHECK_ERROR:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCode()Ljava/lang/String;

    move-result-object p2

    sget-object v2, Lcom/taobao/agoo/a;->ACCS_CHECK_ERROR:Lcom/alibaba/sdk/android/error/ErrorCode;

    .line 189
    invoke-virtual {v2}, Lcom/alibaba/sdk/android/error/ErrorCode;->getMsg()Ljava/lang/String;

    move-result-object v2

    .line 188
    invoke-virtual {p1, p2, v2}, Lcom/taobao/agoo/IRegister;->onFailure(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    :cond_5
    iget-object p2, p0, Lcom/taobao/agoo/c;->a:Lcom/taobao/agoo/IRegister;

    if-eqz p2, :cond_7

    .line 193
    invoke-static {}, Lcom/taobao/agoo/TaobaoRegister;->access$000()Lcom/taobao/agoo/a/b;

    move-result-object p2

    iget-object p2, p2, Lcom/taobao/agoo/a/b;->a:Ljava/util/Map;

    iget-object v2, p0, Lcom/taobao/agoo/c;->a:Lcom/taobao/agoo/IRegister;

    invoke-interface {p2, p1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_0

    :cond_6
    iget-object p2, p0, Lcom/taobao/agoo/c;->a:Lcom/taobao/agoo/IRegister;

    if-eqz p2, :cond_7

    const-string p2, "no error msg"

    .line 199
    invoke-static {p1, p2}, Lcom/taobao/agoo/a;->a(ILjava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object p1

    const-string p2, "bindApp"

    invoke-virtual {p1, p2}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->detail(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object p1

    .line 200
    invoke-virtual {p1}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object p1

    iget-object p2, p0, Lcom/taobao/agoo/c;->a:Lcom/taobao/agoo/IRegister;

    .line 201
    invoke-virtual {p1}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCode()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p1}, Lcom/alibaba/sdk/android/error/ErrorCode;->getMsg()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2, v2, p1}, Lcom/taobao/agoo/IRegister;->onFailure(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception p1

    const-string p2, "register onBindApp"

    new-array v1, v1, [Ljava/lang/Object;

    .line 205
    invoke-static {v0, p2, p1, v1}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    :cond_7
    :goto_0
    return-void
.end method

.method public onBindApp(ILjava/lang/String;Ljava/lang/String;)V
    .locals 1

    .line 144
    sget-object v0, Lcom/taobao/accs/AccsErrorCode;->SUCCESS:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v0

    if-ne p1, v0, :cond_0

    .line 145
    invoke-virtual {p0, p1, p3}, Lcom/taobao/agoo/c;->onBindApp(ILjava/lang/String;)V

    goto :goto_0

    :cond_0
    iget-object p3, p0, Lcom/taobao/agoo/c;->a:Lcom/taobao/agoo/IRegister;

    if-eqz p3, :cond_1

    .line 149
    invoke-static {p1, p2}, Lcom/taobao/agoo/a;->a(ILjava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object p1

    const-string p2, "bindApp"

    invoke-virtual {p1, p2}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->detail(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object p1

    invoke-virtual {p1}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object p1

    iget-object p2, p0, Lcom/taobao/agoo/c;->a:Lcom/taobao/agoo/IRegister;

    .line 150
    invoke-virtual {p1}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCode()Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p1}, Lcom/alibaba/sdk/android/error/ErrorCode;->getMsg()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2, p3, p1}, Lcom/taobao/agoo/IRegister;->onFailure(Ljava/lang/String;Ljava/lang/String;)V

    :cond_1
    :goto_0
    return-void
.end method
