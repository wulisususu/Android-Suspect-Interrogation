.class public final enum Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Type;
.super Ljava/lang/Enum;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "Type"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Type;",
        ">;"
    }
.end annotation


# static fields
.field public static final enum a:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Type;

.field public static final enum b:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Type;

.field public static final enum c:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Type;

.field private static final synthetic d:[Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Type;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .line 1
    new-instance v0, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Type;

    const-string v1, "INCOMPLETE"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Type;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Type;->a:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Type;

    .line 2
    new-instance v0, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Type;

    const-string v1, "JAVA"

    const/4 v2, 0x1

    invoke-direct {v0, v1, v2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Type;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Type;->b:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Type;

    .line 3
    new-instance v0, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Type;

    const-string v1, "NATIVE"

    const/4 v2, 0x2

    invoke-direct {v0, v1, v2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Type;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Type;->c:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Type;

    .line 4
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Type;->a()[Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Type;

    move-result-object v0

    sput-object v0, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Type;->d:[Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Type;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0

    .line 1
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method private static synthetic a()[Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Type;
    .locals 3

    sget-object v0, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Type;->a:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Type;

    sget-object v1, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Type;->b:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Type;

    sget-object v2, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Type;->c:Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Type;

    filled-new-array {v0, v1, v2}, [Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Type;

    move-result-object v0

    return-object v0
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Type;
    .locals 1

    const-class v0, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Type;

    .line 1
    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Type;

    return-object p0
.end method

.method public static values()[Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Type;
    .locals 1

    sget-object v0, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Type;->d:[Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Type;

    .line 1
    invoke-virtual {v0}, [Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Type;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Type;

    return-object v0
.end method
