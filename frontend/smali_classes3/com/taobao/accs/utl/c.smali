.class public Lcom/taobao/accs/utl/c;
.super Lcom/taobao/accs/IAppReceiverV2;
.source "Taobao"


# instance fields
.field private final a:Lcom/taobao/accs/IAppReceiver;

.field private b:Z


# direct methods
.method private constructor <init>(Lcom/taobao/accs/IAppReceiver;)V
    .locals 1

    .line 30
    invoke-direct {p0}, Lcom/taobao/accs/IAppReceiverV2;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/taobao/accs/utl/c;->b:Z

    iput-object p1, p0, Lcom/taobao/accs/utl/c;->a:Lcom/taobao/accs/IAppReceiver;

    return-void
.end method

.method public static a(Lcom/taobao/accs/IAppReceiver;)Lcom/taobao/accs/IAppReceiver;
    .locals 1

    if-nez p0, :cond_0

    const/4 p0, 0x0

    return-object p0

    .line 23
    :cond_0
    new-instance v0, Lcom/taobao/accs/utl/c;

    invoke-direct {v0, p0}, Lcom/taobao/accs/utl/c;-><init>(Lcom/taobao/accs/IAppReceiver;)V

    return-object v0
.end method

.method public static a(Lcom/alibaba/sdk/android/error/ErrorCode;Lcom/taobao/accs/IAppReceiver;)V
    .locals 1

    .line 178
    instance-of v0, p1, Lcom/taobao/accs/IAppReceiverV2;

    if-eqz v0, :cond_0

    .line 179
    check-cast p1, Lcom/taobao/accs/IAppReceiverV2;

    invoke-virtual {p0}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v0

    invoke-virtual {p0}, Lcom/alibaba/sdk/android/error/ErrorCode;->getMsg()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p1, v0, p0}, Lcom/taobao/accs/IAppReceiverV2;->onUnbindApp(ILjava/lang/String;)V

    goto :goto_0

    .line 181
    :cond_0
    invoke-virtual {p0}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result p0

    invoke-interface {p1, p0}, Lcom/taobao/accs/IAppReceiver;->onUnbindApp(I)V

    :goto_0
    return-void
.end method

.method public static a(Lcom/alibaba/sdk/android/error/ErrorCode;Lcom/taobao/accs/IAppReceiver;Ljava/lang/String;)V
    .locals 1

    .line 168
    instance-of v0, p1, Lcom/taobao/accs/IAppReceiverV2;

    if-eqz v0, :cond_0

    .line 169
    check-cast p1, Lcom/taobao/accs/IAppReceiverV2;

    invoke-virtual {p0}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v0

    invoke-virtual {p0}, Lcom/alibaba/sdk/android/error/ErrorCode;->getMsg()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p1, v0, p0, p2}, Lcom/taobao/accs/IAppReceiverV2;->onBindApp(ILjava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    .line 170
    :cond_0
    instance-of v0, p1, Lcom/taobao/accs/IAppReceiverV1;

    if-eqz v0, :cond_1

    .line 171
    check-cast p1, Lcom/taobao/accs/IAppReceiverV1;

    invoke-virtual {p0}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result p0

    invoke-virtual {p1, p0, p2}, Lcom/taobao/accs/IAppReceiverV1;->onBindApp(ILjava/lang/String;)V

    goto :goto_0

    .line 173
    :cond_1
    invoke-virtual {p0}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result p0

    invoke-interface {p1, p0}, Lcom/taobao/accs/IAppReceiver;->onBindApp(I)V

    :goto_0
    return-void
.end method

.method public static b(Lcom/alibaba/sdk/android/error/ErrorCode;Lcom/taobao/accs/IAppReceiver;)V
    .locals 1

    .line 193
    instance-of v0, p1, Lcom/taobao/accs/IAppReceiverV2;

    if-eqz v0, :cond_0

    .line 194
    check-cast p1, Lcom/taobao/accs/IAppReceiverV2;

    invoke-virtual {p0}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v0

    invoke-virtual {p0}, Lcom/alibaba/sdk/android/error/ErrorCode;->getMsg()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p1, v0, p0}, Lcom/taobao/accs/IAppReceiverV2;->onUnbindUser(ILjava/lang/String;)V

    goto :goto_0

    .line 196
    :cond_0
    invoke-virtual {p0}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result p0

    invoke-interface {p1, p0}, Lcom/taobao/accs/IAppReceiver;->onUnbindUser(I)V

    :goto_0
    return-void
.end method

.method public static b(Lcom/alibaba/sdk/android/error/ErrorCode;Lcom/taobao/accs/IAppReceiver;Ljava/lang/String;)V
    .locals 1

    .line 186
    instance-of v0, p1, Lcom/taobao/accs/IAppReceiverV2;

    if-eqz v0, :cond_0

    .line 187
    check-cast p1, Lcom/taobao/accs/IAppReceiverV2;

    invoke-virtual {p0}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v0

    invoke-virtual {p0}, Lcom/alibaba/sdk/android/error/ErrorCode;->getMsg()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p1, p2, v0, p0}, Lcom/taobao/accs/IAppReceiverV2;->onBindUser(Ljava/lang/String;ILjava/lang/String;)V

    goto :goto_0

    .line 189
    :cond_0
    invoke-virtual {p0}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result p0

    invoke-interface {p1, p2, p0}, Lcom/taobao/accs/IAppReceiver;->onBindUser(Ljava/lang/String;I)V

    :goto_0
    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 1

    .line 155
    instance-of v0, p1, Lcom/taobao/accs/utl/c;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/taobao/accs/utl/c;->a:Lcom/taobao/accs/IAppReceiver;

    .line 156
    check-cast p1, Lcom/taobao/accs/utl/c;

    iget-object p1, p1, Lcom/taobao/accs/utl/c;->a:Lcom/taobao/accs/IAppReceiver;

    invoke-virtual {v0, p1}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result p1

    return p1

    :cond_0
    iget-object v0, p0, Lcom/taobao/accs/utl/c;->a:Lcom/taobao/accs/IAppReceiver;

    .line 158
    invoke-virtual {v0, p1}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result p1

    return p1
.end method

.method public getAllServices()Ljava/util/Map;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lcom/taobao/accs/utl/c;->a:Lcom/taobao/accs/IAppReceiver;

    .line 150
    invoke-interface {v0}, Lcom/taobao/accs/IAppReceiver;->getAllServices()Ljava/util/Map;

    move-result-object v0

    return-object v0
.end method

.method public getService(Ljava/lang/String;)Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/taobao/accs/utl/c;->a:Lcom/taobao/accs/IAppReceiver;

    .line 145
    invoke-interface {v0, p1}, Lcom/taobao/accs/IAppReceiver;->getService(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method public hashCode()I
    .locals 1

    iget-object v0, p0, Lcom/taobao/accs/utl/c;->a:Lcom/taobao/accs/IAppReceiver;

    .line 163
    invoke-virtual {v0}, Ljava/lang/Object;->hashCode()I

    move-result v0

    return v0
.end method

.method public onBindApp(I)V
    .locals 1

    iget-boolean v0, p0, Lcom/taobao/accs/utl/c;->b:Z

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/taobao/accs/utl/c;->b:Z

    iget-object v0, p0, Lcom/taobao/accs/utl/c;->a:Lcom/taobao/accs/IAppReceiver;

    .line 49
    invoke-interface {v0, p1}, Lcom/taobao/accs/IAppReceiver;->onBindApp(I)V

    :goto_0
    return-void
.end method

.method public onBindApp(ILjava/lang/String;)V
    .locals 2

    iget-boolean v0, p0, Lcom/taobao/accs/utl/c;->b:Z

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/taobao/accs/utl/c;->b:Z

    iget-object v0, p0, Lcom/taobao/accs/utl/c;->a:Lcom/taobao/accs/IAppReceiver;

    .line 59
    instance-of v1, v0, Lcom/taobao/accs/IAppReceiverV1;

    if-eqz v1, :cond_1

    .line 60
    check-cast v0, Lcom/taobao/accs/IAppReceiverV1;

    invoke-virtual {v0, p1, p2}, Lcom/taobao/accs/IAppReceiverV1;->onBindApp(ILjava/lang/String;)V

    goto :goto_0

    .line 62
    :cond_1
    invoke-interface {v0, p1}, Lcom/taobao/accs/IAppReceiver;->onBindApp(I)V

    :goto_0
    return-void
.end method

.method public onBindApp(ILjava/lang/String;Ljava/lang/String;)V
    .locals 2

    iget-boolean v0, p0, Lcom/taobao/accs/utl/c;->b:Z

    if-eqz v0, :cond_0

    goto :goto_0

    .line 73
    :cond_0
    sget-object v0, Lcom/taobao/accs/AccsErrorCode;->SUCCESS:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v0

    if-ne p1, v0, :cond_1

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/taobao/accs/utl/c;->b:Z

    :cond_1
    iget-object v0, p0, Lcom/taobao/accs/utl/c;->a:Lcom/taobao/accs/IAppReceiver;

    .line 76
    instance-of v1, v0, Lcom/taobao/accs/IAppReceiverV2;

    if-eqz v1, :cond_2

    .line 77
    check-cast v0, Lcom/taobao/accs/IAppReceiverV2;

    invoke-virtual {v0, p1, p2, p3}, Lcom/taobao/accs/IAppReceiverV2;->onBindApp(ILjava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    .line 78
    :cond_2
    instance-of p2, v0, Lcom/taobao/accs/IAppReceiverV1;

    if-eqz p2, :cond_3

    .line 79
    check-cast v0, Lcom/taobao/accs/IAppReceiverV1;

    invoke-virtual {v0, p1, p3}, Lcom/taobao/accs/IAppReceiverV1;->onBindApp(ILjava/lang/String;)V

    goto :goto_0

    .line 81
    :cond_3
    invoke-interface {v0, p1}, Lcom/taobao/accs/IAppReceiver;->onBindApp(I)V

    :goto_0
    return-void
.end method

.method public onBindUser(Ljava/lang/String;I)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/accs/utl/c;->a:Lcom/taobao/accs/IAppReceiver;

    .line 112
    invoke-interface {v0, p1, p2}, Lcom/taobao/accs/IAppReceiver;->onBindUser(Ljava/lang/String;I)V

    return-void
.end method

.method public onBindUser(Ljava/lang/String;ILjava/lang/String;)V
    .locals 2

    iget-object v0, p0, Lcom/taobao/accs/utl/c;->a:Lcom/taobao/accs/IAppReceiver;

    .line 117
    instance-of v1, v0, Lcom/taobao/accs/IAppReceiverV2;

    if-eqz v1, :cond_0

    .line 118
    check-cast v0, Lcom/taobao/accs/IAppReceiverV2;

    invoke-virtual {v0, p1, p2, p3}, Lcom/taobao/accs/IAppReceiverV2;->onBindUser(Ljava/lang/String;ILjava/lang/String;)V

    goto :goto_0

    .line 120
    :cond_0
    invoke-interface {v0, p1, p2}, Lcom/taobao/accs/IAppReceiver;->onBindUser(Ljava/lang/String;I)V

    :goto_0
    return-void
.end method

.method public onData(Ljava/lang/String;Ljava/lang/String;[B)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/accs/utl/c;->a:Lcom/taobao/accs/IAppReceiver;

    .line 40
    invoke-interface {v0, p1, p2, p3}, Lcom/taobao/accs/IAppReceiver;->onData(Ljava/lang/String;Ljava/lang/String;[B)V

    return-void
.end method

.method public onSendData(Ljava/lang/String;I)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/accs/utl/c;->a:Lcom/taobao/accs/IAppReceiver;

    .line 140
    invoke-interface {v0, p1, p2}, Lcom/taobao/accs/IAppReceiver;->onSendData(Ljava/lang/String;I)V

    return-void
.end method

.method public onUnbindApp(I)V
    .locals 1

    iget-boolean v0, p0, Lcom/taobao/accs/utl/c;->b:Z

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/taobao/accs/utl/c;->b:Z

    iget-object v0, p0, Lcom/taobao/accs/utl/c;->a:Lcom/taobao/accs/IAppReceiver;

    .line 90
    invoke-interface {v0, p1}, Lcom/taobao/accs/IAppReceiver;->onUnbindApp(I)V

    :cond_0
    return-void
.end method

.method public onUnbindApp(ILjava/lang/String;)V
    .locals 2

    iget-boolean v0, p0, Lcom/taobao/accs/utl/c;->b:Z

    if-eqz v0, :cond_1

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/taobao/accs/utl/c;->b:Z

    iget-object v0, p0, Lcom/taobao/accs/utl/c;->a:Lcom/taobao/accs/IAppReceiver;

    .line 100
    instance-of v1, v0, Lcom/taobao/accs/IAppReceiverV2;

    if-eqz v1, :cond_0

    .line 101
    check-cast v0, Lcom/taobao/accs/IAppReceiverV2;

    invoke-virtual {v0, p1, p2}, Lcom/taobao/accs/IAppReceiverV2;->onUnbindApp(ILjava/lang/String;)V

    goto :goto_0

    .line 103
    :cond_0
    invoke-interface {v0, p1}, Lcom/taobao/accs/IAppReceiver;->onUnbindApp(I)V

    :cond_1
    :goto_0
    return-void
.end method

.method public onUnbindUser(I)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/accs/utl/c;->a:Lcom/taobao/accs/IAppReceiver;

    .line 126
    invoke-interface {v0, p1}, Lcom/taobao/accs/IAppReceiver;->onUnbindUser(I)V

    return-void
.end method

.method public onUnbindUser(ILjava/lang/String;)V
    .locals 2

    iget-object v0, p0, Lcom/taobao/accs/utl/c;->a:Lcom/taobao/accs/IAppReceiver;

    .line 131
    instance-of v1, v0, Lcom/taobao/accs/IAppReceiverV2;

    if-eqz v1, :cond_0

    .line 132
    check-cast v0, Lcom/taobao/accs/IAppReceiverV2;

    invoke-virtual {v0, p1, p2}, Lcom/taobao/accs/IAppReceiverV2;->onUnbindUser(ILjava/lang/String;)V

    goto :goto_0

    .line 134
    :cond_0
    invoke-interface {v0, p1}, Lcom/taobao/accs/IAppReceiver;->onUnbindUser(I)V

    :goto_0
    return-void
.end method
