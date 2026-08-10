.class public Lcom/aliyun/emas/apm/remote/log/RemoteLogOptions;
.super Lcom/aliyun/emas/apm/ApmProductOptions;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/aliyun/emas/apm/remote/log/RemoteLogOptions$Builder;
    }
.end annotation


# instance fields
.field private a:I


# direct methods
.method private constructor <init>(I)V
    .locals 0

    .line 2
    invoke-direct {p0}, Lcom/aliyun/emas/apm/ApmProductOptions;-><init>()V

    iput p1, p0, Lcom/aliyun/emas/apm/remote/log/RemoteLogOptions;->a:I

    return-void
.end method

.method synthetic constructor <init>(ILcom/aliyun/emas/apm/remote/log/RemoteLogOptions$a;)V
    .locals 0

    .line 1
    invoke-direct {p0, p1}, Lcom/aliyun/emas/apm/remote/log/RemoteLogOptions;-><init>(I)V

    return-void
.end method


# virtual methods
.method public getRemoteLogFileMaxSize()I
    .locals 1

    iget v0, p0, Lcom/aliyun/emas/apm/remote/log/RemoteLogOptions;->a:I

    return v0
.end method
