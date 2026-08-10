.class public final Lcom/aliyun/emas/apm/remote/log/RemoteLogOptions$Builder;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/aliyun/emas/apm/remote/log/RemoteLogOptions;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Builder"
.end annotation


# instance fields
.field private a:I


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/16 v0, 0x14

    iput v0, p0, Lcom/aliyun/emas/apm/remote/log/RemoteLogOptions$Builder;->a:I

    return-void
.end method


# virtual methods
.method public build()Lcom/aliyun/emas/apm/remote/log/RemoteLogOptions;
    .locals 3

    .line 1
    new-instance v0, Lcom/aliyun/emas/apm/remote/log/RemoteLogOptions;

    iget v1, p0, Lcom/aliyun/emas/apm/remote/log/RemoteLogOptions$Builder;->a:I

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lcom/aliyun/emas/apm/remote/log/RemoteLogOptions;-><init>(ILcom/aliyun/emas/apm/remote/log/RemoteLogOptions$a;)V

    return-object v0
.end method

.method public setRemoteLogFileMaxSize(I)Lcom/aliyun/emas/apm/remote/log/RemoteLogOptions$Builder;
    .locals 0

    iput p1, p0, Lcom/aliyun/emas/apm/remote/log/RemoteLogOptions$Builder;->a:I

    return-object p0
.end method
