.class final Lcom/aliyun/emas/apm/crash/internal/model/a$x;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/google/firebase/encoders/ObjectEncoder;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/aliyun/emas/apm/crash/internal/model/a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "x"
.end annotation


# static fields
.field static final a:Lcom/aliyun/emas/apm/crash/internal/model/a$x;

.field private static final b:Lcom/google/firebase/encoders/FieldDescriptor;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 1
    new-instance v0, Lcom/aliyun/emas/apm/crash/internal/model/a$x;

    invoke-direct {v0}, Lcom/aliyun/emas/apm/crash/internal/model/a$x;-><init>()V

    sput-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$x;->a:Lcom/aliyun/emas/apm/crash/internal/model/a$x;

    const-string v0, "content"

    .line 3
    invoke-static {v0}, Lcom/google/firebase/encoders/FieldDescriptor;->of(Ljava/lang/String;)Lcom/google/firebase/encoders/FieldDescriptor;

    move-result-object v0

    sput-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$x;->b:Lcom/google/firebase/encoders/FieldDescriptor;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Log;Lcom/google/firebase/encoders/ObjectEncoderContext;)V
    .locals 1

    sget-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$x;->b:Lcom/google/firebase/encoders/FieldDescriptor;

    .line 1
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Log;->getContent()Ljava/lang/String;

    move-result-object p1

    invoke-interface {p2, v0, p1}, Lcom/google/firebase/encoders/ObjectEncoderContext;->add(Lcom/google/firebase/encoders/FieldDescriptor;Ljava/lang/Object;)Lcom/google/firebase/encoders/ObjectEncoderContext;

    return-void
.end method

.method public bridge synthetic encode(Ljava/lang/Object;Ljava/lang/Object;)V
    .locals 0

    .line 1
    check-cast p1, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Log;

    check-cast p2, Lcom/google/firebase/encoders/ObjectEncoderContext;

    invoke-virtual {p0, p1, p2}, Lcom/aliyun/emas/apm/crash/internal/model/a$x;->a(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Log;Lcom/google/firebase/encoders/ObjectEncoderContext;)V

    return-void
.end method
