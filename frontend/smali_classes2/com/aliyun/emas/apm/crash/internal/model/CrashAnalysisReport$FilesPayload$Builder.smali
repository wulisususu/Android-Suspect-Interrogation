.class public abstract Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload$Builder;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x409
    name = "Builder"
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public abstract build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload;
.end method

.method public abstract setFiles(Ljava/util/List;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload$Builder;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload$File;",
            ">;)",
            "Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload$Builder;"
        }
    .end annotation
.end method

.method public abstract setOrgId(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload$Builder;
.end method
